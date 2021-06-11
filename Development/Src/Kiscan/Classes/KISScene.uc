/**
 * Kiscan GUI Framework
 * 
 * KISScene
 * 
 * Scene is like a container for components. We can also imagine it like a layer in Photoshop. We can place
 * some components like buttons and images there. Moving, hiding or other kind of editing of the scene will affect all these components.
 * Scene can contain SubScenes. They will work like normal scenes however when you hide some main (parent) scene, all subscenes will be invisible
 * too. This rule also applies on the position and some other properties. See Kiscan Documentation for more info.
 * 
 * Responsibilities of this class:
 * 
 * - Create and manage components.
 * - Create and manage subscenes.
 * - Pass all calls to these scenes and components.
 * - Attach the scene to the cursor if needed.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISScene extends KISObject;

/** Dynamic property. Local position of this scene, the final position of the scene can be affected by other things like parent scenes, resolution and so on. */
var(Basic_Appearance) KISGUIPosition Position;

/** True if we want to attach scene to the cursor. This simply means OutputPosition = CursorPosition + AttachToCursorOffset. */
var(Cursor) bool bAttachToCursor;
/** Dynamic property. Offset from the cursor when the scene is attached to it. */
var(Cursor) KISGUIPosition AttachToCursorOffset<EditCondition=bAttachToCursor>;

/** Debug property. Display Position debug graph. */
var(Debug) bool bDrawPosition;
/** Debug property. Display Output Position of the scene. */
var(Debug) bool bDrawOutputPosition;
/** Debug property. Display AttachToCursorOffset debug graph. */
var(Debug) bool bDrawAttachToCursorOffset;
/** Debug property. Display Priority. */
var(Debug) bool bDrawPriority;
/** Debug property. Display Tag. */
var(Debug) bool bDrawTag;
/** Debug property. Color of the debug info. */
var(Debug) Color DebugColor;

/** True if we want to render the scene and all subscenes. Hidden if false. */
var(Rendering) bool bEnabled;
/** Priority sorts scenes and determines what should be closest to the player and what farest. Simply, order of rendering of scenes.
 *  Use SetPriority() function to change this property.*/
var(Rendering) privatewrite int Priority;
/** Type of scaling of the scene and components by the resolution. This is overriden if we have a parent scene. */
var(Rendering) EKISDrawMode DrawMode;
/** Draw movie-like borders if needed because of Show All Draw Mode. */
var(Rendering) bool bDrawShowAllMargin;
/** Color of the a margin. */
var(Rendering) Color ShowAllMarginColor;

/** List of archetypes of Subscenes. */
var(Scene) const array<KISNewScene> SubSceneArchetype;
/** List of archetypes of Components. */
var(Scene) const array<KISNewComponent> ComponentArchetype;

/** Current tag of this scene. We use a tag for example when we want to reference a scene in Kismet. Tag has to be unique for every scene! */
var name Tag;

/** Output property. Final position of this scene in pixels. */
var IntPoint OutputPosition;

/** SubScenes created from the SubSceneArchetype list. */
var array<KISScene> SubScene;
/** Components created from the SubSceneArchetype list. */
var array<KISComponent> DrawComponent;

/** Reference to HUD. */
var KISHUD HUD;
/** Reference to Handle. */
var KISHandle Handle;
/** Reference to Module. Module can be an owner of the scene. */
var KISModule Module;
/** Reference to Scene which owns this scene. Scene can be an owner of the scene too. */
var KISScene ParentScene;

/**
 * ComponentPrioritySort
 * Declaration
 * Delegate that is used to sort components by a priority. For more about the priority
 * see Kiscan Documentation.
 * For more about sort delegates see UDN.
 * 
 * @param A Value to be compared.
 * @param B Value to be compared.
 * 
 * @return New position of the checked value.
 */
delegate int ComponentPrioritySort(KISComponent A, KISComponent B)
{
	local int Result;

	if(A != none && B != none)
	{
		Result = A.Priority > B.Priority ? -1 : 0;
	}

	return Result;
}

/**
 * Init
 * Declaration
 * Initialization of the scene. Called when this scene is newly created.
 * 
 * @param NewHUD Current HUD.
 * @param NewHandle Current Handle.
 * @param NewModule Current Module.
 * @param NewParentScene Reference to an owner scene. This can be none if the scene is created inside Module.
 */
function Init(KISHUD NewHUD, KISHandle NewHandle, KISModule NewModule, KISScene NewParentScene)
{
	local KISNewComponent FoundNewComponent;
	local KISNewScene FoundNewScene;

	HUD = NewHUD;
	Handle = NewHandle;
	Module = NewModule;
	ParentScene = NewParentScene;

	// Add the scene to the list of all scenes in the module
	Module.RegistratedScene.AddItem(self);

	UpdateDynamicProperties();

	// Create components
	foreach ComponentArchetype(FoundNewComponent)
	{
		CreateComponent(FoundNewComponent.Tag,, FoundNewComponent.Component);
	}

	// Create subscenes
	foreach SubSceneArchetype(FoundNewScene)
	{
		CreateSubScene(FoundNewScene.Tag,, FoundNewScene.Scene);
	}
}

/**
 * CreateComponent
 * Declaration
 * Create a new component and add it to the DrawComponent array.
 * You can create a component using a scene class or a scene archetype.
 * 
 * @param NewComponentTag Tag of the new component.
 * @param ComponentClass Class of the new component.
 * @param CompArch Archetype of the new component.
 * 
 * @return Newly created component. None if component can not be created.
 */
function KISComponent CreateComponent(name NewComponentTag, optional class<KISComponent> ComponentClass, optional KISComponent CompArch)
{
	local KISComponent NewComp;

	if(CompArch != none)
	{
		NewComp = new CompArch.Class (CompArch);
	}
	else if(ComponentClass != none)
	{
		NewComp = new ComponentClass;
	}

	if(NewComp != none)
	{
		if(NewComponentTag != '' && Module.GetComponentByTag(NewComponentTag) == none)
		{
			NewComp.Tag = NewComponentTag;
			DrawComponent.AddItem(NewComp);
			DrawComponent.Sort(ComponentPrioritySort); // Update order of all components
			NewComp.Init(HUD, Handle, Module, self);
		}
		else
		{
			NewComp = none;
			`KiscanWarn("Can't create new component, tag \""$string(NewComponentTag)$"\" is invalid.");
		}
	}

	return NewComp;
}

/**
 * CreateSubScene
 * Declaration
 * Create a new subscene and add it to the SubScene array.
 * You can create a subscene using a subscene class or a subscene archetype.
 * 
 * @param NewSceneTag Tag of the new subscene.
 * @param SceneClass Class of the new subscene.
 * @param SceneArchetype Archetype of the new subscene.
 * 
 * @return Newly created subscene. None if the scene can not be created.
 */
function KISScene CreateSubScene(name NewSceneTag, optional class<KISScene> SceneClass, optional KISScene SceneArchetype)
{
	local KISScene NewScene;

	if(SceneArchetype != none)
	{
		NewScene = new SceneArchetype.Class (SceneArchetype);
	}
	else if(SceneClass != none)
	{
		NewScene = new SceneClass;
	}

	if(NewScene != none)
	{
		if(NewSceneTag != '' && Module.GetSceneByTag(NewSceneTag) == none)
		{
			NewScene.Tag = NewSceneTag;
			SubScene.AddItem(NewScene);
			SubScene.Sort(Module.ScenePrioritySort);
			NewScene.Init(HUD, Handle, Module, self);
		}
		else
		{
			NewScene = none;
			`KiscanWarn("Can't create new scene, tag \""$string(NewSceneTag)$"\" is invalid.");
		}
	}

	return NewScene;
}

/**
 * Update
 * Declaration
 * Function that is called always before rendering. You can do some needed calculations there.
 * Called every frame.
 * 
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function Update(float DeltaTime)
{
	local KISComponent FoundComponent;
	local KISScene FoundScene;

	if(bEnabled)
	{
		if(bAttachToCursor && ParentScene == none)
		{
			// Recalculate the position if scene is attached to the cursor
			UpdateDynamicProperties();
		}

		// Update components
		foreach DrawComponent(FoundComponent)
		{
			FoundComponent.Update(DeltaTime);
		}

		// Update subscenes
		foreach SubScene(FoundScene)
		{
			FoundScene.Update(DeltaTime);
		}
	}
}

/**
 * Render
 * Declaration
 * Main function used for a drawing of the GUI.
 * Called every frame.
 * 
 * @param C Current Canvas that can be used for drawing.
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function Render(Canvas C, float DeltaTime)
{
	local KISComponent FoundComponent;
	local KISScene FoundScene;
	local float ShowAllSizeY;

	if(bEnabled)
	{
		// Render components
		foreach DrawComponent(FoundComponent)
		{
			FoundComponent.Render(C, DeltaTime);
			FoundComponent.RenderDebug(C, DeltaTime);
		}

		RenderDebug(C, DeltaTime);

		// Render subscenes
		foreach SubScene(FoundScene)
		{
			FoundScene.Render(C, DeltaTime);
		}

		// Render the Show All margin
		if(bDrawShowAllMargin && GetDrawMode() == DM_ShowAll)
		{
			ShowAllSizeY = HUD.SizeX * (float(Handle.Settings.NativeResolution.Y) / Handle.Settings.NativeResolution.X);

			C.SetPos(0,0);
			C.SetDrawColorStruct(ShowAllMarginColor);
			C.DrawRect(HUD.SizeX, (HUD.SizeY - ShowAllSizeY) / 2.f);

			C.SetPos(0,HUD.SizeY - (HUD.SizeY - ShowAllSizeY) / 2.f);
			C.SetDrawColorStruct(ShowAllMarginColor);
			C.DrawRect(HUD.SizeX, (HUD.SizeY - ShowAllSizeY) / 2.f);
		}
	}
}

/**
 * RenderDebug
 * Declaration
 * Draw debug of this scene.
 * Called every frame.
 * 
 * @param C Current Canvas that can be used for drawing.
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function RenderDebug(Canvas C, float DeltaTime)
{
	local IntPoint MousePos;
	local string DebugString;
	local float ShowAllPosY, NoBorderPosX;

	if(bEnabled)
	{
		if(bDrawPosition)
		{
			if(ParentScene != none)
			{
				DrawDebugPosition(C, ParentScene.OutputPosition, Position, GetDrawMode(), Handle);
			}
			else
			{
				if(GetDrawMode() == DM_ShowAll)
				{
					ShowAllPosY = (HUD.SizeY - (HUD.SizeX * (float(Handle.Settings.NativeResolution.Y) / Handle.Settings.NativeResolution.X))) / 2;
				}
				else if(GetDrawMode() == DM_NoBorder)
				{
					NoBorderPosX = ((HUD.SizeY * (float(Handle.Settings.NativeResolution.X) / Handle.Settings.NativeResolution.Y)) - HUD.SizeX) / 2;
				}

				DrawDebugPosition(C, MakeIP(-NoBorderPosX,ShowAllPosY), Position, GetDrawMode(), Handle);
			}
		}

		if(bDrawOutputPosition)
		{
			DrawDebugCross(C, OutputPosition.X, OutputPosition.Y, 15, DebugColor);
			DebugString @= "OutPosX:"@OutputPosition.X$", OutPosY:"@OutputPosition.Y;
		}

		if(bDrawAttachToCursorOffset)
		{
			MousePos.X = Handle.MousePosition.X;
			MousePos.Y = Handle.MousePosition.Y;
			DrawDebugPosition(C, MousePos, AttachToCursorOffset, GetDrawMode(), Handle);
		}

		if(bDrawPriority)
		{
			DebugString @= "Pri:"@Priority;
		}

		if(bDrawTag)
		{
			DebugString @= "Tag:"@string(Tag);
		}

		DrawDebugText(C, OutputPosition.X, OutputPosition.Y, DebugString, DebugColor);
	}
}

/**
 * UpdateDynamicProperties
 * Declaration
 * This function manages all important properties of the scene. Many properties are linked with other
 * so they need to be changed together. Call this function after every change of some property or the resolution.
 */
function UpdateDynamicProperties()
{
	local KISScene FoundScene;
	local KISComponent FoundComponent;
	local float ShowAllSizeY, NoBorderSizeX;

	// Get the current position
	OutputPosition = GetAdjustedPosition(Position, GetDrawMode(), Handle);

	if(ParentScene == none)
	{
		if(GetDrawMode() == DM_ShowAll)
		{
			ShowAllSizeY = HUD.SizeX * (float(Handle.Settings.NativeResolution.Y) / Handle.Settings.NativeResolution.X);

			OutputPosition.Y += (HUD.SizeY - ShowAllSizeY) / 2;
		}
		else if(GetDrawMode() == DM_NoBorder)
		{
			NoBorderSizeX = HUD.SizeY * (float(Handle.Settings.NativeResolution.X) / Handle.Settings.NativeResolution.Y);

			OutputPosition.X -= (NoBorderSizeX - HUD.SizeX) / 2;
		}
	}

	// Add the position of the parent scene
	if(ParentScene != none)
	{
		OutputPosition.X += ParentScene.OutputPosition.X;
		OutputPosition.Y += ParentScene.OutputPosition.Y;
	}
	else
	{
		if(bAttachToCursor)
		{
			// Override the positon if we are attached to the cursor
			OutputPosition = GetAdjustedPosition(AttachToCursorOffset, GetDrawMode(), Handle);
			OutputPosition.X += Handle.MousePosition.X;
			OutputPosition.Y += Handle.MousePosition.Y;
		}
	}

	// We need to update also components because components are linked/attached to the scene
	foreach DrawComponent(FoundComponent)
	{
		FoundComponent.UpdateDynamicProperties();
	}

	// We need to update also subscenes because subscenes are linked/attached to the parent scene (this one)
	foreach SubScene(FoundScene)
	{
		FoundScene.UpdateDynamicProperties();
	}
}

/**
 * SetPriority
 * Declaration
 * Change order of rendering of scenes.
 * 
 * @param NewPriority New priority of this scene.
 */
function SetPriority(int NewPriority)
{
	Priority = NewPriority;

	if(ParentScene != none)
	{
		ParentScene.SubScene.Sort(Module.ScenePrioritySort);
	}
	else
	{
		Module.DrawScene.Sort(Module.ScenePrioritySort);
	}
}

/**
 * GetDrawMode
 * Declaration
 * Return the current Draw Mode which is used by this scene.
 * We use the function for this because Draw Mode can be overriden
 * by Parent Scene.
 * 
 * @return Current Draw Mode.
 */
function EKISDrawMode GetDrawMode()
{
	return ParentScene != none ? ParentScene.GetDrawMode() : DrawMode;
}

/**
 * Destroy
 * Declaration
 * Delete scene and all components, subscenes and so on...
 */
function Destroy()
{
	local KISComponent FoundComponent;
	local KISScene FoundScene;

	if(ParentScene != none)
	{
		ParentScene.SubScene.RemoveItem(self);
	}
	else
	{
		Module.DrawScene.RemoveItem(self);
	}

	Module.RegistratedScene.RemoveItem(self);

	HUD = none;
	Handle = none;
	Module = none;
	ParentScene = none;

	foreach DrawComponent(FoundComponent)
	{
		FoundComponent.Destroy();
	}

	foreach SubScene(FoundScene)
	{
		FoundScene.Destroy();
	}
}

defaultproperties
{
	DebugColor=(R=255,G=0,B=255,A=255)
	ShowAllMarginColor=(R=0,G=0,B=0,A=255)
	bEnabled=true
}