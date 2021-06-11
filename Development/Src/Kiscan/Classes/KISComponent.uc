/**
 * Kiscan GUI Framework
 * 
 * KISComponent
 * 
 * Component is a container for Canvas Objects. To better understand components we need to know what
 * Canvas Objects are. 
 * Canvas Object is an object which manages only rendering part of one visual object e.g. image,
 * text and so on. Components control rendering and properties of contained Canvas Objects.
 * We have various components like Buttons, Checkboxes, Radio Buttons, Text Inputs,.... All these components contain
 * lists or individual Canvas Objects. For example Button contains three lists of Canvas Objects: Idle, Hover, Clicked.
 * That means you can create unlimited number of Canvas Objects in every list and every list will be rendered
 * in some other situation. 
 * Some components can work with only one Canvas Object e.g. Text Input.
 * To easily make new lists or individual Canvas Objects we use CanvasObjectList and CanvasObjectSpecial.
 * These classes are like bridges between Component and Canvas Object.
 * 
 * Component is base a class for all other components. It contains only one list: Static, which is always rendered.
 * 
 * Responsibilities of this class:
 * 
 * - Create and manage Canvas Object lists and specials (KISCanvasObjectList, KISCanvasObjectSpecial).
 * - Manage individual Canvas Objects if needed.
 * - Pass all relevant calls to lists and specials.
 * - Process player's input.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISComponent extends KISObject;

/** Dynamic property. Local position of this scene, the final position of the scene can be affected by other things like parent scenes, resolution and so on. */
var(Basic_Appearance) KISGUIPosition Position;

/** True if we want to attach component to the cursor. This simply means OutputPosition = CursorPosition + AttachToCursorOffset. */
var(Cursor) bool bAttachToCursor;
/** Dynamic property. Offset from the cursor when the component is attached to it. */
var(Cursor) KISGUIPosition AttachToCursorOffset<EditCondition=bAttachToCursor>;

/** Debug property. Display Position debug graph. */
var(Debug) bool bDrawPosition;
/** Debug property. Display Output Position of the component. */
var(Debug) bool bDrawOutputPosition;
/** Debug property. Display AttachToCursorOffset debug graph. */
var(Debug) bool bDrawAttachToCursorOffset;
/** Debug property. Display Priority. */
var(Debug) bool bDrawPriority;
/** Debug property. Display Tag. */
var(Debug) bool bDrawTag;
/** Debug property. Show true if the cursor is hovering on this component. */
var(Debug) bool bDrawMouseHover;
/** Debug property. Color of the debug info. */
var(Debug) Color DebugColor;

/** Enable Kismet Event - Component > Mouse Hover. Disable this if you don't use it for better performance. */
var(Kismet) bool bTriggerKismetEvent_MouseHover;
/** Enable Kismet Event - Component > Mouse Input. Disable this if you don't use it for better performance. */
var(Kismet) bool bTriggerKismetEvent_MouseInput;

/** Canvas Objects that are always rendered. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_Static<DisplayName="CO List - Static">;

/** True if we want to show/render this component. */
var(Rendering) bool bEnabled;
/** Priority sorts components and determines what should be closest to the player and what farest. Simply, order of rendering of components.
 *  Use SetPriority() function to change this property.*/
var(Rendering) privatewrite int Priority;

/** Current tag of this component. We use a tag for example when we want to reference a component in Kismet. Tag has to be unique for every scene! */
var name Tag;
/** All COLists in one array. */
var array<KISCanvasObjectList> COLists;
/** All COSpecial in one array. */
var array<KISCanvasObjectSpecial> COSpecial;

/** Output property. Final position of this component in pixels. */
var IntPoint OutputPosition;

/** True if the mouse cursor is hovering on this component. */
var bool bMouseHover;
/** We store there an offset from the cursor calculated when the player clicked on this component. We can acces this in kismet. */
var IntPoint LeftClickDiff;
/** We store there an offset from the cursor calculated when the player clicked on this component. We can acces this in kismet. */
var IntPoint RightClickDiff;
/** We store there an offset from the cursor calculated when the player clicked on this component. We can acces this in kismet. */
var IntPoint MiddleClickDiff;

/** For developers only. True if this component can process Character Input. See KISInput and KISHandle for more info about input types. */
var const bool bCaptureCharacterInput;
/** For developers only. True if this component can process Key Input. See KISInput and KISHandle for more info about input types. */
var const bool bCaptureKeyInput;

/** Reference to HUD. */
var KISHUD HUD;
/** Reference to Handle. */
var KISHandle Handle;
/** Reference to Module. */
var KISModule Module;
/** Reference to parent Scene. Scene is owner of Component. */
var KISScene ParentScene;

/**
 * Init
 * Declaration
 * Initialization of the component. Called when this component is newly created.
 * 
 * @param NewHUD Current HUD.
 * @param NewHandle Current Handle.
 * @param NewModule Current Module.
 * @param NewParentScene Reference to an owner scene.
 */
function Init(KISHUD NewHUD, KISHandle NewHandle, KISModule NewModule, KISScene NewParentScene)
{
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;

	HUD = NewHUD;
	Handle = NewHandle;
	Module = NewModule;
	ParentScene = NewParentScene;

	// Add the component to the list of all component in the module
	Module.RegistratedComponent.AddItem(self);

	// Add the component to the list of components that can process these types of an input
	if(bCaptureCharacterInput)
	{
		Handle.CharacterInputComponent.AddItem(self);
	}
	if(bCaptureKeyInput)
	{
		Handle.KeyInputComponent.AddItem(self);
	}

	LoadCOLists();
	LoadCOSpecial();

	foreach COLists(FoundCOList)
	{
		FoundCOList.Init(HUD, Handle, Module, ParentScene, self);
	}

	foreach COSpecial(FoundCOSpecial)
	{
		FoundCOSpecial.Init(HUD, Handle, Module, ParentScene, self);
	}

	UpdateDynamicProperties();
}

/**
 * LoadCOLists
 * Declaration
 * COLists are merged in one array in this function.
 * We merge then in one array because it is much easier for updating. We can simply do foreach on this array and update all lists.
 * We exposed this in another function because it is easier to create new lists in child components.
 */
function LoadCOLists()
{
	COLists.AddItem(COList_Static);
}

/**
 * LoadCOSpecial
 * Declaration
 * COSpecials are merged in one array in this function.
 * We merge then in one array because it is much easier for updating. We can simply do foreach on this array and update all specials.
 * We exposed this in another function because it is easier to create new specials in child components.
 */
function LoadCOSpecial();

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
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;

	if(bEnabled)
	{
		if(bAttachToCursor)
		{
			UpdateDynamicProperties();
		}

		// Update canvas objects
		foreach COLists(FoundCOList)
		{
			FoundCOList.Update(DeltaTime);
		}

		foreach COSpecial(FoundCOSpecial)
		{
			FoundCOSpecial.Update(DeltaTime);
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
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;

	if(bEnabled)
	{
		// Render canvas objects
		foreach COLists(FoundCOList)
		{
			FoundCOList.Render(C, DeltaTime);
		}

		foreach COSpecial(FoundCOSpecial)
		{
			FoundCOSpecial.Render(C, DeltaTime);
		}
	}
}

/**
 * RenderDebug
 * Declaration
 * Draw debug of this component.
 * Called every frame.
 * 
 * @param C Current Canvas that can be used for drawing.
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function RenderDebug(Canvas C, float DeltaTime)
{
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;
	local IntPoint MousePos;
	local string DebugString;

	if(bEnabled)
	{
		if(bDrawPosition)
		{
			DrawDebugPosition(C, ParentScene.OutputPosition, Position, GetDrawMode(), Handle);
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

		if(bDrawMouseHover)
		{
			DebugString @= "Hover:"@bMouseHover;
		}

		DrawDebugText(C, OutputPosition.X, OutputPosition.Y, DebugString, DebugColor);

		foreach COLists(FoundCOList)
		{
			FoundCOList.RenderDebug(C, DeltaTime);
		}

		foreach COSpecial(FoundCOSpecial)
		{
			FoundCOSpecial.RenderDebug(C, DeltaTime);
		}
	}
}

/**
 * UpdateDynamicProperties
 * Declaration
 * This function manages all important properties of the component. Many properties are linked with other
 * so they need to be changed together. Call this function after every change of some property or the resolution.
 */
function UpdateDynamicProperties()
{
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;

	if(bAttachToCursor)
	{
		OutputPosition = GetAdjustedPosition(AttachToCursorOffset, GetDrawMode(), Handle);
		OutputPosition.X += Handle.MousePosition.X;
		OutputPosition.Y += Handle.MousePosition.Y;
	}
	else
	{
		OutputPosition = GetAdjustedPosition(Position, GetDrawMode(), Handle);
		OutputPosition.X += ParentScene.OutputPosition.X;
		OutputPosition.Y += ParentScene.OutputPosition.Y;
	}

	// Update also canvas objects
	foreach COLists(FoundCOList)
	{
		FoundCOList.UpdateDynamicProperties();
	}

	foreach COSpecial(FoundCOSpecial)
	{
		FoundCOSpecial.UpdateDynamicProperties();
	}
}

/**
 * IsOnShape
 * Declaration
 * Return true if CheckPosition is placed on this component.
 * This function checks shapes of all canvas objects.
 * Usually used when determining what is under the cursor.
 * 
 * @param CheckPosition 2D Coord. For example mouse position.
 * @param Out_bOnTransparentShape True if this component is "transparent" for input.
 * 
 * @return True if CheckPosition is on this component.
 */
function bool IsOnShape(IntPoint CheckPosition, out byte Out_bOnTransparentShape)
{
	local bool bResult;
	local bool bCurrentResult;
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;
	local byte CurrentOnTransparentShape;
	
	foreach COSpecial(FoundCOSpecial)
	{
		bCurrentResult = FoundCOSpecial.IsOnShape(CheckPosition, CurrentOnTransparentShape);

		if(bCurrentResult)
		{
			// CheckPosition is on this component
			bResult = true;
			Out_bOnTransparentShape = CurrentOnTransparentShape;

			if(CurrentOnTransparentShape == 0)
			{
				// This canvas object is not transparent so we can end searching
				break;
			}
		}
	}

	if(!bResult || Out_bOnTransparentShape == 1)
	{
		foreach COLists(FoundCOList)
		{
			bCurrentResult = FoundCOList.IsOnShape(CheckPosition, CurrentOnTransparentShape);

			if(bCurrentResult)
			{
				// CheckPosition is on this component
				bResult = true;
				Out_bOnTransparentShape = CurrentOnTransparentShape;

				if(CurrentOnTransparentShape == 0)
				{
					// This canvas object is not transparent so we can end searching
					break;
				}
			}
		}
	}

	return bResult;
}

/**
 * HandleMouseInput
 * Declaration
 * Process the mouse input.
 * Called from KISHandle.
 * 
 * @param Button Name of the button.
 * @param EventType Type of the event. Like released, pressed and so on...
 * 
 * @return True if we want to trap the input. This means that this input will not be passed further in the engine. It is useful for example when we want to
 * press some button but don't want to fire from weapon.
 */
function bool HandleMouseInput(name Button, EInputEvent EventType)
{
	local int InputIndex;

	if(EventType == IE_Pressed)
	{
		switch(Button)
		{
			case 'LeftMouseButton':
				LeftClickDiff = GetMouseDifference(OutputPosition, Handle);
				InputIndex = 0;
				break;
			case 'RightMouseButton':
				RightClickDiff = GetMouseDifference(OutputPosition, Handle);
				InputIndex = 2;
				break;
			case 'MiddleMouseButton':
				MiddleClickDiff = GetMouseDifference(OutputPosition, Handle);
				InputIndex = 4;
				break;
			case 'MouseScrollUp':
				InputIndex = 6;
				break;
			case 'MouseScrollDown':
				InputIndex = 7;
				break;
			default:
				break;
		}
	}
	else if(EventType == IE_Released)
	{
		switch(Button)
		{
			case 'LeftMouseButton':
				InputIndex = 1;
				break;
			case 'RightMouseButton':
				InputIndex = 3;
				break;
			case 'MiddleMouseButton':
				InputIndex = 5;
				break;
			case 'MouseScrollUp':
				InputIndex = INDEX_NONE;
				break;
			case 'MouseScrollDown':
				InputIndex = INDEX_NONE;
				break;
			default:
				break;
		}
	}

	if(bTriggerKismetEvent_MouseInput && InputIndex != INDEX_NONE)
	{
		HUD.TriggerGlobalTagEvent(class'KISSeqEvent_Comp_MouseInput', Tag, InputIndex);
	}

	return false;
}

/**
 * HandleHover
 * Declaration
 * Called when the mouse cursor enters on this component or left it.
 * 
 * @param EventType 0 = Mouse left this component, 1 = Mouse entered on this component.
 */
function HandleHover(byte EventType)
{
	if(EventType == 0)
	{
		bMouseHover = false;

		if(bTriggerKismetEvent_MouseHover)
		{
			HUD.TriggerGlobalTagEvent(class'KISSeqEvent_Comp_MouseHover', Tag, 1);
		}
	}
	else
	{
		bMouseHover = true;

		if(bTriggerKismetEvent_MouseHover)
		{
			HUD.TriggerGlobalTagEvent(class'KISSeqEvent_Comp_MouseHover', Tag, 0);
		}
	}
}

/**
 * HandleKeyInput
 * Declaration
 * Process the key input.
 * Called from KISHandle.
 * 
 * @param ControllerId The controller that generated this input key event.
 * @param Key The name of the key which an event occured for (Enter, LeftControl, X, K, etc.).
 * @param Event The type of event which occured (pressed, released, etc.).
 * @param AmountDepressed For analog keys, the depression percent.
 * @param bGamepad Input came from gamepad (ie xbox controller).
 * 
 * @return True if we want to trap the input. This means that this input will not be passed further in the engine. It is useful for example when we want to
 * write some text in KISComponent_Button_TextInput but don't want to move a character with WSAD when typing.
 */
function bool HandleKeyInput(int ControllerId, name Key, EInputEvent Event, int AmountDepressed, bool bGamepad)
{
	return false;
}

/**
 * HandleCharacterInput
 * Declaration
 * Process the character input.
 * Called from KISHandle.
 * 
 * @param ControllerId The controller that generated this input key event.
 * @param Unicode The character that was typed.
 * 
 * @return True if we want to trap the input. This means that this input will not be passed further in the engine. It is useful for example when we want to
 * write some text in KISComponent_Button_TextInput but don't want to move a character with WSAD when typing.
 */
function bool HandleCharacterInput(int ControllerId, string Unicode)
{
	return false;
}

/**
 * GetCOByTag
 * Declaration
 * Return Canvas Object with same tag as COTag.
 * 
 * @param COTag CO tag to look for.
 * 
 * @return Found CO.
 */
function KISCanvasObject GetCOByTag(name COTag)
{
	local KISCanvasObject Result;
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;
	local KISCanvasObject FoundCO;

	if(COTag != '')
	{
		foreach COLists(FoundCOList)
		{
			foreach FoundCOList.CanvasObject(FoundCO)
			{
				if(FoundCO.Tag == COTag)
				{
					Result = FoundCO;
					break;
				}
			}

			if(Result != none)
			{
				break;
			}
		}

		if(Result == none)
		{
			foreach COSpecial(FoundCOSpecial)
			{
				if(FoundCOSpecial.CanvasObject != none)
				{
					if(FoundCOSpecial.CanvasObject.Tag == COTag)
					{
						Result = FoundCOSpecial.CanvasObject;
						break;
					}
				}
			}
		}
	}

	return Result;
}

/**
 * GetCOListByTag
 * Declaration
 * Return Canvas Object List with same tag as COListTag.
 * 
 * @param COListTag COList tag to look for.
 * 
 * @return Found COList.
 */
function KISCanvasObjectList GetCOListByTag(name COListTag)
{
	local KISCanvasObjectList Result;
	local KISCanvasObjectList FoundCOList;
	
	if(COListTag != '')
	{
		foreach COLists(FoundCOList)
		{
			if(FoundCOList.Tag == COListTag)
			{
				Result = FoundCOList;
				break; 
			}
		}
	}

	return Result;
}

/**
 * GetCOSpecialByTag
 * Declaration
 * Return Canvas Object Special with same tag as COSpecialTag.
 * 
 * @param COSpecialTag COSpecial tag to look for.
 * 
 * @return Found COSpecial.
 */
function KISCanvasObjectSpecial GetCOSpecialByTag(name COSpecialTag)
{
	local KISCanvasObjectSpecial Result;
	local KISCanvasObjectSpecial FoundCOSpecial;

	if(COSpecialTag != '')
	{
		foreach COSpecial(FoundCOSpecial)
		{
			if(FoundCOSpecial.Tag == COSpecialTag)
			{
				Result = FoundCOSpecial;
				break;
			}
		}
	}

	return Result;
}

/**
 * SetPriority
 * Declaration
 * Change order of rendering of components.
 * 
 * @param NewPriority New priority of this component.
 */
function SetPriority(int NewPriority)
{
	Priority = NewPriority;
	ParentScene.DrawComponent.Sort(ParentScene.ComponentPrioritySort);
}

/**
 * IsComponentRendered
 * Declaration
 * Retrun true if this component is being rendered.
 * 
 * @param SearchScene Use none if you are calling this function. This is used only for recursive calls this function use.
 * 
 * @return True if this component is being rendered.
 */
function bool IsComponentRendered(optional KISScene SearchScene = ParentScene)
{
	local bool bResult;

	if(bEnabled)
	{
		if(SearchScene.bEnabled)
		{
			if(SearchScene.ParentScene != none)
			{
				bResult = IsComponentRendered(SearchScene.ParentScene);
			}
			else
			{
				bResult = true;
			}
		}
		else
		{
			bResult = false;
		}
	}
	else
	{
		bResult = false;
	}

	return bResult;
}

/**
 * GetDrawMode
 * Declaration
 * Return the current Draw Mode which is used by this component.
 * We use the function for this because Draw Mode can be overriden
 * by Parent Scenes.
 * 
 * @return Current Draw Mode.
 */
function EKISDrawMode GetDrawMode()
{
	return ParentScene.GetDrawMode();
}

/**
 * Destroy
 * Declaration
 * Delete Component and all Canvas Objects...
 */
function Destroy()
{
	local KISCanvasObjectList FoundCOList;
	local KISCanvasObjectSpecial FoundCOSpecial;

	Module.RegistratedComponent.RemoveItem(self);

	Handle.HoverComponent.RemoveItem(self);
	Handle.CharacterInputComponent.RemoveItem(self);
	Handle.KeyInputComponent.RemoveItem(self);
	Handle.LeftClickedComponent.RemoveItem(self);
	Handle.RightClickedComponent.RemoveItem(self);
	Handle.MiddleClickedComponent.RemoveItem(self);
	if(Handle.SelectedComponent == self)
	{
		Handle.SelectedComponent = none;
	}

	ParentScene.DrawComponent.RemoveItem(self);

	HUD = none;
	Handle = none;
	Module = none;
	ParentScene = none;

	foreach COLists(FoundCOList)
	{
		FoundCOList.Destroy();
	}

	foreach COSpecial(FoundCOSpecial)
	{
		FoundCOSpecial.Destroy();
	}
}

defaultproperties
{
	// CO Lists and CO Specials
	Begin Object Class=KISCanvasObjectList Name=COList_Static
		Tag=Static
	End Object
	COList_Static=COList_Static

	DebugColor=(R=0,G=255,B=255,A=255)
	bEnabled=true
}