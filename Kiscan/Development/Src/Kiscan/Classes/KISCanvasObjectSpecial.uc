/**
 * Kiscan GUI Framework
 * 
 * KISCanvasObjectSpecial
 * 
 * KISCanvasObjectList (COList) and KISCanvasObjectSpecial (COSpecial) are very similar classes and represent a bridge between Component and COs. They group multiple COs into one list and give
 * a programmer an ability to control the rendering of the list.
 * They make working with COs in a code much cleaner.
 * 
 * We do not have an editable archetype variable there. It is because we use subclasses with specific classes of that variable.
 * For example, Component Input Text can work only with CO Simple Text. To enforce this, we used KISCanvasObjectSpecial_SimpleText there.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISCanvasObjectSpecial extends KISObject
	abstract;

/** We fill this variable on initialization. We store there real CO created from an archetype stored in some variable defined in subclasses. */
var KISCanvasObject CanvasObject;

/** Tag/Name of COSpecial. We use Tag when we want to reference certain COSpecial in a code. We can get that reference using Component.GetCOSpecialByTag(). There can not be two COSpecials with same Tag in one Component.
 *  Specify Tag in defaultproperties of Component. */
var const name Tag;
/** Set false if you want to disable (hide) this COSpecial. COSpecial will not be processed anymore. This can be controlled only by code. */
var bool bRender;

/** Reference to HUD. */
var KISHUD HUD;
/** Reference to Handle. */
var KISHandle Handle;
/** Reference to Module. */
var KISModule Module;
/** Reference to parent Scene of Component. */
var KISScene ParentScene;
/** Reference to Parent Component. It is the owner of COSpecial. */
var KISComponent ParentComponent;

/**
 * Init
 * Declaration
 * Initialization happens when an object is newly created. We usually use PostBeginPlay() in Actors, however Object classes don't provide a function
 * like that, so we need to create custom one. We call Init() immediately after the creation of a new object.
 * We pass the chain of references as paramaters.
 * 
 * @param NewHUD Current HUD.
 * @param NewHandle Current Handle.
 * @param NewModule Current Module.
 * @param NewParentScene Reference to the scene.
 * @param NewParentComponent Reference to the owner component.
 */
function Init(KISHUD NewHUD, KISHandle NewHandle, KISModule NewModule, KISScene NewParentScene, KISComponent NewParentComponent)
{
	HUD = NewHUD;
	Handle = NewHandle;
	Module = NewModule;
	ParentScene = NewParentScene;
	ParentComponent = NewParentComponent;
}

/**
 * CreateCanvasObject
 * Declaration
 * Creates a new CO.
 * You can create CO using a class or an archetype.
 * If you specify both, the archetype will be prefered.
 * 
 * @param NewCOTag Tag of the new CO.
 * @param COClass Class of the new CO.
 * @param COArchetype Archetype of the new CO.
 * 
 * @return Newly created CO. None if CO can not be created.
 */
function KISCanvasObject CreateCanvasObject(name NewCOTag, optional class<KISCanvasObject> COClass, optional KISCanvasObject COArchetype)
{
	local KISCanvasObject NewCO;

	if(CanvasObject != none)
	{
		CanvasObject.Destroy();
		CanvasObject = none;
	}

	if(COArchetype != none)
	{
		NewCO = new COArchetype.Class (COArchetype);
	}
	else if(COClass != none)
	{
		NewCO = new COClass;
	}

	if(NewCO != none)
	{
		if(NewCOTag != '' && ParentComponent.GetCOByTag(NewCOTag) == none)
		{
			NewCO.Tag = NewCOTag;
			CanvasObject = NewCO;
			NewCO.Init(HUD, Handle, Module, ParentScene, ParentComponent, none, self);
		}
		else
		{
			NewCO = none;
			`KiscanWarn("Can't create new canvas object in component"@ParentComponent.Tag$", tag \""$string(NewCOTag)$"\" is invalid.");
		}
	}

	return NewCO;
}

/**
 * Update
 * Declaration
 * Called always before the rendering. We can do there calculations that have to happen before the rendering process.
 * It is also cleaner because we do not mix calcuations with rendering.
 * Called every frame.
 * 
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function Update(float DeltaTime)
{
	if(bRender)
	{
		if(CanvasObject != none)
		{
			CanvasObject.Update(DeltaTime);
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
	if(bRender)
	{
		if(CanvasObject != none)
		{
			CanvasObject.Render(C, DeltaTime);
		}
	}
}

/**
 * RenderDebug
 * Declaration
 * Rendering function used for rendering of the debug.
 * This is always called after Render().
 * Called every frame.
 * 
 * @param C Current Canvas.
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function RenderDebug(Canvas C, float DeltaTime)
{
	if(bRender)
	{
		if(CanvasObject != none)
		{
			CanvasObject.RenderDebug(C, DeltaTime);
		}
	}
}

/**
 * UpdateDynamicProperties
 * Declaration
 * Recalculates output properties from fixed properties.
 * This is also called when the resolution gets changed because output properties depend on the size and the ratio
 * of the screen. We need to call this everytime we change some variable because many variables depend on each other.
 * Call this everytime you change any property!
 */
function UpdateDynamicProperties()
{
	if(CanvasObject != none)
	{
		CanvasObject.UpdateDynamicProperties();
	}
}

/**
 * IsOnShape
 * Declaration
 * Checks if CheckPosition is located on Input Shape of CO.
 * Framework usually use it when determining what is under the cursor.
 * 
 * @param CheckPosition 2D Coords.
 * @param Out_bOnTransparentShape True if CheckPosition is on transparent Input Shape.
 * 
 * @return True if CheckPosition is located on CO of this COSpecial.
 */
function bool IsOnShape(IntPoint CheckPosition, out byte Out_bOnTransparentShape)
{
	local bool bResult;
	local bool bCurrentResult;
	local byte CurrentOnTransparentShape;
	
	if(bRender)
	{
		if(CanvasObject != none)
		{
			bCurrentResult = CanvasObject.IsOnShape(CheckPosition, CurrentOnTransparentShape);

			if(bCurrentResult)
			{
				bResult = true;
				Out_bOnTransparentShape = CurrentOnTransparentShape;
			}
		}
	}

	return bResult;
}

/**
 * Destroy
 * Declaration
 * Destroys this object and all possible references to it, so Garbage Collector
 * will be able to process it.
 */
function Destroy()
{
	ParentComponent.COSpecial.RemoveItem(self);

	HUD = none;
	Handle = none;
	Module = none;
	ParentScene = none;
	ParentComponent = none;

	if(CanvasObject != none)
	{
		CanvasObject.Destroy();
	}
}

defaultproperties
{
	bRender=true
}
