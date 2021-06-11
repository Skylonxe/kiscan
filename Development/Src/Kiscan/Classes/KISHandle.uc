/**
 * Kiscan GUI Framework
 * 
 * KISHandle
 * 
 * KISHandle is the root class of the framework. The hierarchy tree of the framework is:
 * KISHUD -> KISHandle -> KISModule -> KISScene -> KISComponent -> KISCanvasObjectList/Special -> KISCanvasObject
 * KISHandle manages the input and sends relevant checks to scenes and components. It also determines what is under the cursor
 * and what objects are pressed.
 * 
 * Responsibilities of this class:
 * 
 * - Create modules. Each module is like a layer. Right now we use only one module - KISModule_GUI. That is where our the
 * GUI is rendered. We plan to add another special modules for debugging later.
 * - Perform collision checks and create the list of objects that are under the cursor.
 * - Calculate the screen ratio which is later used for scaling of scenes.
 * - Send input to components that are allowed to process it.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISHandle extends KISObject;

/** Current 2D position of mouse cursor. */
var Vector2D MousePosition;

/** Current size of the screen compared to the native resolution specified in KISSettings. Used when calculating the scale of scenes based on some draw modes. For more about
 *  draw modes see Kiscan Documentation. */
var Vector2D ScreenRatio;

/** List of components that are under the cursor. */
var array<KISComponent> HoverComponent;
/** List of components that can accept the key input. See the KISInput class for more details about the key input. */
var array<KISComponent> KeyInputComponent;
/** List of components that can accept the character input. See the KISInput class for more details about the character input. */
var array<KISComponent> CharacterInputComponent;

/** Lists of components which are pressed by the left mouse button right now. We store this list because we will need to send the released event
 *  to same components later. */
var array<KISComponent> LeftClickedComponent;
/** Lists of components which are pressed by the right mouse button right now. We store this list because we will need to send the released event
 *  to same components later. */
var array<KISComponent> RightClickedComponent;
/** Lists of components which are pressed by the middle mouse button right now. We store this list because we will need to send the released event
 *  to same components later. */
var array<KISComponent> MiddleClickedComponent;

/** Component which is currently selected by the player. This can be for example component KISComponent_Button_TextInput. */
var KISComponent SelectedComponent;

/** List of modules. As said in the class description. KISModule is next in framework rendering chain and represents one workspace or a layer. We use only one now - KISModule_GUI however this
 *  can change later when we will want to implement another layers like special windows for debugging that are not affected by the gameplay GUI. */
var array<KISModule> Module;

/** Overtype mode of text writing. Works like in every other software. You can toggle it with Insert when writing inside for example KISComponent_Button_TextInput.
 *  We use the SetTextOvertypeMode() function to change it.*/
var privatewrite bool bTextOvertypeMode;

/** True if ctrl is pressed.*/
var bool bCtrlPressed;
/** True if shift is pressed.*/
var bool bShiftPressed;
/** True if alt is pressed.*/
var bool bAltPressed;

/** True if handle has been successfully initialized.*/
var bool bInitialized;

/** Reference to the player's HUD. HUD is owner of this class.*/
var KISHUD HUD;
/** Reference to the current settings.*/
var KISSettings Settings;

/**
 * Init
 * Declaration
 * Called when KISHandle is created. It initialize some default values and creates modules.
 * HUD calls this function.
 * 
 * @param NewHUD HUD which created this handle.
 * @param NewSettings Settings that are used for initialization of this handle.
 */
function Init(KISHUD NewHUD, KISSettings NewSettings)
{
	local KISModule FoundModule;

	if(!bInitialized && NewSettings != none)
	{
		if(NewSettings.NativeResolution.X > 0 && NewSettings.NativeResolution.Y > 0)
		{
			HUD = NewHUD;
			Settings = NewSettings;

			if(KISPlayerController(HUD.PlayerOwner) != none)
			{
				// Change keybinding of console keys if needed
				if(Settings.bOverwriteConsoleBinding)
				{
					KISPlayerController(HUD.PlayerOwner).SetConsoleKey(Settings.SmallConsoleKey);
					KISPlayerController(HUD.PlayerOwner).SetTypeKey(Settings.ConsoleKey);
				}
			}

			UpdateRatio();

			// Create modules
			Module[0] = new class'KISModule_GUI';
			Module[1] = new class'KISModule_Debugger'; // KISModule_Debugger is created however It draws nothing because we don't use it yet in this version

			// Initialize modules, modules than initialize scenes, scenes initialize components and so on...
			foreach Module(FoundModule)
			{
				FoundModule.Init(HUD, self);
			}

			bInitialized = true;
		}
	}
}

/**
 * Render
 * Declaration
 * The most important function of the framework. This is start of the rendering chain where all the drawing happens.
 * Called every frame.
 * 
 * @param C Current Canvas used for drawing. See UDN for more info about Canvas.
 * @param DeltaTime Current DeltaTime. Time since last frame. See Epic Forum for more info.
 * @param NewMousePosition Current position of mouse cursor.
 */
function Render(Canvas C, float DeltaTime, Vector2D NewMousePosition)
{
	local KISModule FoundModule;

	if(bInitialized)
	{
		MousePosition = NewMousePosition;

		// Update HoverComponent list
		GetHoverComponents();

		// Here starts another important call chain. Update function is passed in every module, scene, component and canvas object.
		// It is always called before rendering. Many checks, animations and so on happens in these functions.
		foreach Module(FoundModule)
		{
			FoundModule.Update(DeltaTime);
		}

		// Render module, module than pass this call to scenes and so on...
		foreach Module(FoundModule)
		{
			FoundModule.Render(C, DeltaTime);
		}

		// Render handle debug
		RenderDebug(C, DeltaTime);
	}
}

/**
 * RenderDebug
 * Declaration
 * Draws the debug of this handle.
 * Called every frame.
 * 
 * @param C Current Canvas used for drawing. See UDN for more info about Canvas.
 * @param DeltaTime Current DeltaTime. Time since last frame. See Epic Forum for more info.
 */
function RenderDebug(Canvas C, float DeltaTime)
{
	// Draw debug cursor, you can enable rendering of this debug in KISSettings archetype
	if(Settings.bDrawDebugCursor)
	{
		C.SetDrawColorStruct(Settings.DebugCursorColor);
		DrawDebugCross(C, MousePosition.X, MousePosition.Y, 10, Settings.DebugCursorColor);
		DrawDebugText(C, MousePosition.X, MousePosition.Y, FFloor(MousePosition.X)$","@FFloor(MousePosition.Y),Settings.DebugCursorColor);
	}
}

/**
 * NotifyResChange
 * Declaration
 * Called when the resolution gets changed. We update the ratio and then pass this call further because all scenes, components and canvas objects need to do
 * their updates to specific values like the size and the position too.
 */
function NotifyResChange()
{
	local KISModule FoundModule;

	if(bInitialized)
	{
		UpdateRatio();

		// Pass call to module, module will send it further
		foreach Module(FoundModule)
		{
			FoundModule.NotifyResChange();
		}
	}
}

/**
 * UpdateRatio
 * Declaration
 * Updates the current screen ratio based on the native resolution speicified in the settings.
 */
function UpdateRatio()
{
	ScreenRatio.X = HUD.SizeX / Settings.NativeResolution.X;
	ScreenRatio.Y = HUD.SizeY / Settings.NativeResolution.Y;
}

/**
 * HandleMouseInput
 * Declaration
 * Process the mouse input and send it to components that are under the cursor (HoverComponent list).
 * Called from KISInput.
 * 
 * @param Button Name of the button.
 * @param EventType Type of the event. Like released, pressed and so on...
 * 
 * @return True if we want to trap the input. This means that this input will not be passed further in the engine. It is useful for example when we want to
 * press some button but don't want to fire from weapon.
 */
function bool HandleMouseInput(name Button, EInputEvent EventType)
{
	local KISComponent FoundComponent;
	local bool bTrapInput;

	if(bInitialized)
	{
		if(EventType == IE_Released)
		{
			// Notify clicked components that button is released now
			switch(Button)
			{
				case 'LeftMouseButton':
					foreach LeftClickedComponent(FoundComponent)
					{
						FoundComponent.HandleMouseInput(Button, EventType);
					}
					LeftClickedComponent.Length = 0;
					break;
				case 'RightMouseButton':
					foreach RightClickedComponent(FoundComponent)
					{
						FoundComponent.HandleMouseInput(Button, EventType);
					}
					RightClickedComponent.Length = 0;
					break;
				case 'MiddleMouseButton':
					foreach MiddleClickedComponent(FoundComponent)
					{
						FoundComponent.HandleMouseInput(Button, EventType);
					}
					MiddleClickedComponent.Length = 0;
					break;
				default:
					break;
			}
		}
		else
		{
			// Clean out selected component, if we clicked on some selectable component than that component will set it back to appropriate value
			SelectedComponent = none;

			foreach HoverComponent(FoundComponent)
			{
				// Send call to components
				bTrapInput = FoundComponent.HandleMouseInput(Button, EventType);

				// Add components to array of clicked components
				switch(Button)
				{
					case 'LeftMouseButton':
						LeftClickedComponent.AddItem(FoundComponent);
						break;
					case 'RightMouseButton':
						RightClickedComponent.AddItem(FoundComponent);
						break;
					case 'MiddleMouseButton':
						MiddleClickedComponent.AddItem(FoundComponent);
						break;
					default:
						break;
				}

				if(bTrapInput)
				{
					break;
				}
			}
		}
	}

	return bTrapInput;
}

/**
 * HandleKeyInput
 * Declaration
 * Process the key input and send it to components that have enabled the key input by bCaptureKeyInput (KeyInputComponent array).
 * Called from KISInput.
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
function bool HandleKeyInput(int ControllerId, name Key, EInputEvent Event, float AmountDepressed, bool bGamepad)
{
	local KISComponent FoundComponent;
	local bool bTrapInput;

	if(bInitialized)
	{
		if(Event == IE_Pressed || Event == IE_Released)
		{
			// Set Ctrl/Shift/Alt flag
			switch(Key)
			{
				case 'LeftControl':
				case 'RightControl':
					bCtrlPressed = (Event == IE_Pressed);
					break;
				case 'LeftShift':
				case 'RightShift':
					bShiftPressed = (Event == IE_Pressed);
				case 'LeftAlt':
				case 'RightAlt':
					bAltPressed = (Event == IE_Pressed);
					break;
				default:
					break;
			}
		}

		// Send input to components
		foreach KeyInputComponent(FoundComponent)
		{
			bTrapInput = FoundComponent.HandleKeyInput(ControllerId, Key, Event, AmountDepressed, bGamepad);

			if(bTrapInput)
			{
				break;
			}
		}
	}

	return bTrapInput;
}

/**
 * HandleCharacterInput
 * Declaration
 * Process the character input and send it to components that have enabled the character input by bCaptureCharacterInput (CharacterInputComponent array).
 * Called from KISInput.
 * 
 * @param ControllerId The controller that generated this input key event.
 * @param Unicode The character that was typed.
 * 
 * @return True if we want to trap the input. This means that this input will not be passed further in the engine. It is useful for example when we want to
 * write some text in KISComponent_Button_TextInput but don't want to move a character with WSAD when typing.
 */
function bool HandleCharacterInput(int ControllerId, string Unicode)
{
	local KISComponent FoundComponent;
	local bool bTrapInput;

	if(bInitialized)
	{
		foreach CharacterInputComponent(FoundComponent)
		{
			bTrapInput = FoundComponent.HandleCharacterInput(ControllerId, Unicode);

			if(bTrapInput)
			{
				break;
			}
		}
	}

	return bTrapInput;
}

/**
 * GetHoverComponents
 * Declaration
 * Create the list of components that are under the cursor. Calls a hover start on news components and a hover end on old components.
 * Components are sorted from nearest to farest.
 * 
 * @param SearchScene The scene which is used for searching. This is needed because of recursive calls. When the scene contains some subscene GetHoverComponents() is called with the subscene as the parameter.
 * None means - start the completly new search.
 * 
 * @return True if we should end current recursive search because we hit some component.
 */
function bool GetHoverComponents(optional KISScene SearchScene)
{
	local bool bResult;
	local bool bFound;
	local array<KISComponent> OldHover;
	local KISComponent FoundComponent;
	local byte OnTransparentShape;
	local int i, j;

	if(SearchScene == none)
	{
		// Start completly new search
		OldHover = HoverComponent;
		HoverComponent.Length = 0;

		for(i=Module.Length-1;i>=0;i--)
		{
			for(j=Module[i].DrawScene.Length-1;j>=0;j--)
			{
				if(Module[i].DrawScene[j] != none && Module[i].DrawScene[j].bEnabled)
				{
					bFound = GetHoverComponents(Module[i].DrawScene[j]);

					if(bFound)
					{
						break;
					}
				}
			}

			if(bFound)
			{
				break;
			}
		}

		foreach HoverComponent(FoundComponent)
		{
			if(OldHover.Find(FoundComponent) == INDEX_NONE)
			{
				// Call hover start on new components
				FoundComponent.HandleHover(1);
			}
		}

		foreach OldHover(FoundComponent)
		{
			if(HoverComponent.Find(FoundComponent) == INDEX_NONE)
			{
				// Call hover ent on old components that are not under the cursor anymore
				FoundComponent.HandleHover(0);
			}
		}
	}
	else
	{
		// Try to find some subscene in current scene
		for(i=SearchScene.SubScene.Length-1;i>=0;i--)
		{
			if(SearchScene.SubScene[i] != none && SearchScene.SubScene[i].bEnabled)
			{
				bFound = GetHoverComponents(SearchScene.SubScene[i]);

				if(bFound)
				{
					break;
				}
			}
		}

		if(!bFound)
		{
			// Search through individual components
			for(i=SearchScene.DrawComponent.Length-1;i>=0;i--)
			{
				if(SearchScene.DrawComponent[i] != none && SearchScene.DrawComponent[i].bEnabled)
				{
					if(SearchScene.DrawComponent[i].IsOnShape(Vec2IP(MousePosition), OnTransparentShape))
					{
						// Component is under cursor
						HoverComponent.AddItem(SearchScene.DrawComponent[i]);

						// Is component's shape transparent ? Transparent means that search can continue and cache another components that are under the cursor
						if(OnTransparentShape == 0)
						{
							bResult = true;
							break;
						}
					}
				}
			}
		}	
	}

	return bResult;
}

/**
 * SetTextOvertypeMode
 * Declaration
 * Set overtype text mode. For example Insert key uses this when typing inside KISComponent_Button_TextInput.
 * 
 * @param bNewTextOvertypeMode New value
 */
function SetTextOvertypeMode(bool bNewTextOvertypeMode)
{
	bTextOvertypeMode = bNewTextOvertypeMode;
}

/**
 * Destroy
 * Declaration
 * Destroy this handle and send the call to modules. We need to destroy everything manually because we extend our classes from the Object class.
 * Objects need to have their references set to none if we want to destroy them.
 */
function Destroy()
{
	local KISModule FoundModule;

	foreach Module(FoundModule)
	{
		FoundModule.Destroy();
	}

	HUD = none;
	Settings = none;
}