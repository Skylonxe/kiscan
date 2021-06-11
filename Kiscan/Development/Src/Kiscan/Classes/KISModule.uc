/**
 * Kiscan GUI Framework
 * 
 * KISModule
 * 
 * KISModule is a class that creates first scenes of the GUI. These scenes can then contain their own subscenes so theoretically
 * only one scene is needed to be created directly in KISModule.
 * The framework is divided into modules to give developers an ability to work with multiple GUIs at the same time. Right now we use only one
 * module KISModule_GUI, however we plan to add some other modules later. Using modules we will be able to create independent GUIs that are not affected by the main game UI.
 * For example we are able to create a debugger window that is not controllable from the kismet so for example you will not be able to hide it from the editor.
 * You should remember that all kismet actions work only with KISModule_GUI. Scenes, components, functions of other modules have to be hardcoded.
 * 
 * Responsibilities of this class:
 * 
 * - Create new scenes.
 * - Pass all calls to these scenes.
 * - Give a developer an ability to easily get components or scenes by tags. Kismet actions use these functions.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISModule extends KISObject
	abstract;

/** List of main scenes. This is where rendering chain goes. */
var array<KISScene> DrawScene;

/** List of all components in this module. Components are cached in one list to make searching easier and faster. This is used when we want to get a component by a tag. */
var array<KISComponent> RegistratedComponent;
/** List of all scenes in this module. Scenes are cached in one list to make searching easier and faster. This is used when we want to get a scene by a tag. */
var array<KISScene> RegistratedScene;

/** True if this module can be rendered. */
var bool bRender;

/** Reference to KISHUD. */
var KISHUD HUD;

/** Reference to KISHandle. The handle is owner of the module. */
var KISHandle Handle;

/**
 * ScenePrioritySort
 * Declaration
 * Delegate that is used to sort scenes by a priority. For more about the priority
 * see Kiscan Documentation.
 * For more about sort delegates see UDN.
 * 
 * @param A Value to be compared.
 * @param B Value to be compared.
 * 
 * @return New position of the checked value.
 */
delegate int ScenePrioritySort(KISScene A, KISScene B)
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
 * Initialization of the module. Called from NewHandle.Init()
 * 
 * @param NewHUD Current HUD.
 * @param NewHandle Owner Handle.
 */
function Init(KISHUD NewHUD, KISHandle NewHandle)
{
	HUD = NewHUD;
	Handle = NewHandle;
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
	local KISScene FoundScene;

	if(bRender)
	{
		foreach DrawScene(FoundScene)
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
	local KISScene FoundScene;

	if(bRender)
	{
		foreach DrawScene(FoundScene)
		{
			FoundScene.Render(C, DeltaTime);
		}
	}
}

/**
 * NotifyResChange
 * Declaration
 * Called when the resolution gets changed.
 */
function NotifyResChange()
{
	local KISScene FoundScene;

	foreach DrawScene(FoundScene)
	{
		FoundScene.UpdateDynamicProperties();
	}
}

/**
 * CreateScene
 * Declaration
 * Create a new scene and add it to the DrawScene array.
 * You can create a scene using a scene class or a scene archetype.
 * 
 * @param NewSceneTag Tag of the new scene.
 * @param SceneClass Class of the new scene.
 * @param SceneArchetype Archetype of the new scene.
 * 
 * @return Newly created scene. None if scene can not be created.
 */
function KISScene CreateScene(name NewSceneTag, optional class<KISScene> SceneClass, optional KISScene SceneArchetype)
{
	local KISScene NewScene;

	// Create new scene using archetype or class
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
		if(NewSceneTag != '' && GetSceneByTag(NewSceneTag) == none)
		{
			NewScene.Tag = NewSceneTag;
			DrawScene.AddItem(NewScene);
			DrawScene.Sort(ScenePrioritySort); // Sort scenes by priority
			NewScene.Init(HUD, Handle, self, none);
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
 * GetComponentByTag
 * Declaration
 * Return a component with same tag as the ComponentTag parameter.
 * 
 * @param ComponentTag Tag of the wanted component.
 * 
 * @return Found component. None if not found.
 */
function KISComponent GetComponentByTag(name ComponentTag)
{
	local KISComponent FoundComp;
	local KISComponent Result;

	if(ComponentTag != '')
	{
		foreach RegistratedComponent(FoundComp)
		{
			if(FoundComp.Tag == ComponentTag)
			{
				Result = FoundComp;
				break;
			}
		}
	}

	return Result;
}

/**
 * GetSceneByTag
 * Declaration
 * Return a scene with same tag as the SceneTag parameter.
 * 
 * @param SceneTag Tag of the wanted scene.
 * 
 * @return Found scene. None if not found.
 */
function KISScene GetSceneByTag(name SceneTag)
{
	local KISScene FoundScene;
	local KISScene Result;

	if(SceneTag != '')
	{
		foreach RegistratedScene(FoundScene)
		{
			if(FoundScene.Tag == SceneTag)
			{
				Result = FoundScene;
				break;
			}
		}
	}

	return Result;
}

/**
 * Destroy
 * Declaration
 * Delete module and all scenes, components, and so on...
 */
function Destroy()
{
	local KISScene FoundScene;

	Handle.Module[Handle.Module.Find(self)] = none;

	HUD = none;
	Handle = none;

	foreach DrawScene(FoundScene)
	{
		FoundScene.Destroy();
	}
}

defaultproperties
{
	bRender=true
}