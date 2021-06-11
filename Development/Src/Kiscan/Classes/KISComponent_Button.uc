/**
 * Kiscan GUI Framework
 * 
 * KISComponent_Button
 * 
 * Base class for components that works like a button. 
 * Button supports three different states: Idle, Hover, Clicked.
 * Supports also a keyboard activation.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISComponent_Button extends KISComponent;

/** Set true if you want to render the idle list under the hover list. */
var(Button) bool bDrawIdleUnderHover;
/** Set true if you want to render the idle list under the clicked list. */
var(Button) bool bDrawIdleUnderClicked;
/** Set true if oyu want to render the hover list under the clicked list. */
var(Button) bool bDrawHoverUnderClicked;

/** Enable activation by mouse. */
var(Button_Input) bool bActivateByMouseButton;
/** Mouse button which activates this button. */
var(Button_Input) EKISMouseButton MouseButton<EditCondition=bActivateByMouseButton>;
/** Keys that activate this button. */
var(Button_Input) array<name> KeyBind;
/** Button usually sends activation notify when you release a key/mouse button. Set true if you want to fire this notify when you press the button. */
var(Button_Input) bool bUsePressInsteadRelease;

/** This list draws when you do nothing with this button. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_Idle<DisplayName="CO List - Idle">;
/** This list draws when your mouse cursor is on the button. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_Hover<DisplayName="CO List - Hover">;
/** This list draws when button is activated. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_Clicked<DisplayName="CO List - Clicked">;

/** Current state of button: Idle/Hover/Clicked. */ 
var EKISButtonState ButtonState;

/**
 * NotifyButtonActivated
 * Declaration
 * Called when button is activated/clicked.
 * This delegate is not used but can be useful later or for your
 * custom codes.
 */
delegate NotifyButtonActivated();

/**
 * LoadCOLists
 * Override
 */
function LoadCOLists()
{
	super.LoadCOLists();

	// Add new COLists
	COLists.AddItem(COList_Idle);
	COLists.AddItem(COList_Hover);
	COLists.AddItem(COList_Clicked);
}

/**
 * UpdateDynamicProperties
 * Override
 */
function UpdateDynamicProperties()
{
	super.UpdateDynamicProperties();

	// We need to update ButtonState because it possible that cursor is not on the button anymore because e.g. size changed
	SetButtonState(ButtonState);
}

/**
 * HandleMouseInput
 * Override
 */
function bool HandleMouseInput(name Button, EInputEvent EventType)
{
	super.HandleMouseInput(Button, EventType);

	if(bActivateByMouseButton)
	{
		if((Button == 'LeftMouseButton' && MouseButton == MB_Left) || (Button == 'RightMouseButton' && MouseButton == MB_Right) || (Button == 'MiddleMouseButton' && MouseButton == MB_Middle))
		{
			if(EventType == IE_Pressed || EventType == IE_DoubleClick)
			{
				PressButton();
			}
			else if(EventType == IE_Released)
			{
				ReleaseButton();
			}
		}
	}

	return true;
}

/**
 * HandleHover
 * Override
 */
function HandleHover(byte EventType)
{
	super.HandleHover(EventType);

	SetHover(bool(EventType));
}

/**
 * HandleKeyInput
 * Override
 */
function bool HandleKeyInput(int ControllerId, name Key, EInputEvent Event, int AmountDepressed, bool bGamepad)
{
	local bool bTrapInput;

	super.HandleKeyInput(ControllerId, Key, Event, AmountDepressed, bGamepad);

	// Make sure that component is enabled (HandleKeyInput calls on every component without checking variables like bEnabled)
	if(IsComponentRendered())
	{
		// Do we support this key ?
		if(KeyBind.Find(Key) != INDEX_NONE)
		{
			if(Event == IE_Pressed)
			{
				PressButton();
			}
			else if(Event == IE_Released)
			{
				ReleaseButton();
			}
			bTrapInput = true;
		}
	}
	
	return bTrapInput;
}

/**
 * PressButton
 * Declaration
 * Called when button is pressed.
 */
function PressButton()
{
	if(ButtonState != BS_Clicked)
	{
		// Call button activated if needed
		if(bUsePressInsteadRelease)
		{
			ButtonActivated();
		}

		SetButtonState(BS_Clicked);
	}
}

/**
 * ReleaseButton
 * Declaration
 * Called when button is released.
 */
function ReleaseButton()
{
	// Call button activated if it was not called during PressButton()
	if(!bUsePressInsteadRelease)
	{
		ButtonActivated();
	}

	// We are leaving BS_Clicked state however it is very likely possible that the mouse is still hovering on the button
	// so set BS_Hover if needed
	if(bMouseHover)
	{
		SetButtonState(BS_Hover);
	}
	else
	{
		SetButtonState(BS_Idle);
	}
}

/**
 * SetHover
 * Declaration
 * Set Hover state.
 * 
 * @param bOn True if we want to set the hover state. False if we want to turn it off.
 */
function SetHover(bool bOn)
{
	if(ButtonState != BS_Clicked)
	{
		if(bOn)
		{
			SetButtonState(BS_Hover);
		}
		else
		{
			SetButtonState(BS_Idle);
		}
	}
}

/**
 * ButtonActivated
 * Declaration
 * Main function of button.
 * This function is called when button is activated/clicked.
 */
function ButtonActivated()
{
	NotifyButtonActivated();
	HUD.TriggerGlobalTagEvent(class'KISSeqEvent_Comp_Button_Activated', Tag, 0);
}

/**
 * SetButtonState
 * Declaration
 * Enable COLists based on the new state of the button.
 * 
 * @param NewButtonState Required state.
 */
function SetButtonState(EKISButtonState NewButtonState)
{
	switch(NewButtonState)
	{
		case BS_Idle:
			GetCOListByTag('Idle').bRender = true;
			GetCOListByTag('Hover').bRender = false;
			GetCOListByTag('Clicked').bRender = false;
			break;
		case BS_Hover:
			GetCOListByTag('Idle').bRender = bDrawIdleUnderHover;
			GetCOListByTag('Hover').bRender = true;
			GetCOListByTag('Clicked').bRender = false;
			break;
		case BS_Clicked:
			GetCOListByTag('Idle').bRender = bDrawIdleUnderClicked;
			GetCOListByTag('Hover').bRender = bDrawHoverUnderClicked;
			GetCOListByTag('Clicked').bRender = true;
			break;
		default:
			break;
	}

	ButtonState = NewButtonState;
}

defaultproperties
{
	bCaptureKeyInput=true

	Begin Object Class=KISCanvasObjectList Name=COList_Idle
		Tag=Idle
		bRender=true
	End Object
	COList_Idle=COList_Idle

	Begin Object Class=KISCanvasObjectList Name=COList_Hover
		Tag=Hover
		bRender=false
	End Object
	COList_Hover=COList_Hover

	Begin Object Class=KISCanvasObjectList Name=COList_Clicked
		Tag=Clicked
		bRender=false
	End Object
	COList_Clicked=COList_Clicked	

	bActivateByMouseButton=true
}
