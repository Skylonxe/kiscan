/**
 * Kiscan GUI Framework
 * 
 * KISComponent_Button_Checkbox
 * 
 * Checkbox button or toggle button.
 * Supports six COLists: Idle, Hover, Clicked, CheckedIdle, CheckedHover, CheckedClicked.
 * Usually we link this button to a kismet bool variable however delegates allow us to redirect
 * it if needed.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISComponent_Button_Checkbox extends KISComponent_Button;

/** Set true if you want to render the checked idle list under the checked hover list. */
var(Checkbox) bool bDrawCheckedIdleUnderHover;
/** Set true if you want to render the checked idle list under the checked clicked list. */
var(Checkbox) bool bDrawCheckedIdleUnderClicked;
/** Set true if you want to render the checked hover list under the checked clicked list. */
var(Checkbox) bool bDrawCheckedHoverUnderClicked;

/** This list draws when you do nothing with this button but the button is checked. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_CheckedIdle<DisplayName="CO List - Checked Idle">;
/** This list draws when your mouse cursor is on the button and the button is checked. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_CheckedHover<DisplayName="CO List - Checked Hover">;
/** This list draws when checked button is clicked. Usually it means that you are switching it to unchecked state. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_CheckedClicked<DisplayName="CO List - Checked Clicked">;

/** True if this button is checked. Use SetChecked() to change the value. */
var bool bChecked;

/** Linked kismet bool variable. */
var SeqVar_Bool AssignedBool;

/**
 * GetBoolValue
 * Declaration
 * Give ability to link to some other variable in code.
 * Defaultly it looks for the linked kismet variable.
 * 
 * @return Current value of the linked bool variable.
 */
delegate bool GetBoolValue()
{
	local bool bResult;

	if(AssignedBool != none)
	{
		bResult = bool(AssignedBool.bValue);
	}

	return bResult;
}

/**
 * SetBoolValue
 * Declaration
 * Give ability to link to some other variable in code.
 * Defaultly it looks for the linked kismet variable.
 * 
 * @param bNewValue Requested value of linked bool variable.
 */
delegate SetBoolValue(bool bNewValue)
{
	if(AssignedBool != none)
	{
		AssignedBool.bValue = int(bNewValue);
	}
}

/**
 * LoadCOLists
 * Override
 */
function LoadCOLists()
{
	super.LoadCOLists();

	COLists.AddItem(COList_CheckedIdle);
	COLists.AddItem(COList_CheckedHover);
	COLists.AddItem(COList_CheckedClicked);
}

/**
 * Update
 * Override
 */
function Update(float DeltaTime)
{
	super.Update(DeltaTime);

	CheckAssignedBoolMatch();
}

/**
 * CheckAssignedBoolMatch
 * Declaration
 * Check if the state of the checkbox is same as a value of the linked variable.
 * Update the checkbox state if needed.
 */
function CheckAssignedBoolMatch()
{
	if(GetBoolValue() != bChecked)
	{
		SetChecked(GetBoolValue(), true);
	}
}

/**
 * ButtonActivated
 * Override
 * Called when button has been checked or unchecked.
 */
function ButtonActivated()
{
	bChecked = !bChecked;
	SetBoolValue(bChecked);

	super.ButtonActivated();

	HUD.TriggerGlobalTagEvent(class'KISSeqEvent_Comp_Button_Checkbox_Checked', Tag, int(!bChecked));
}

/**
 * SetButtonState
 * Override
 */
function SetButtonState(EKISButtonState NewButtonState)
{
	if(bChecked)
	{
		GetCOListByTag('Idle').bRender = false;
		GetCOListByTag('Hover').bRender = false;
		GetCOListByTag('Clicked').bRender = false;

		switch(NewButtonState)
		{
			case BS_Idle:
				GetCOListByTag('CheckedIdle').bRender = true;
				GetCOListByTag('CheckedHover').bRender = false;
				GetCOListByTag('CheckedClicked').bRender = false;
				break;
			case BS_Hover:
				GetCOListByTag('CheckedIdle').bRender = bDrawCheckedIdleUnderHover;
				GetCOListByTag('CheckedHover').bRender = true;
				GetCOListByTag('CheckedClicked').bRender = false;
				break;
			case BS_Clicked:
				GetCOListByTag('CheckedIdle').bRender = bDrawCheckedIdleUnderClicked;
				GetCOListByTag('CheckedHover').bRender = bDrawCheckedHoverUnderClicked;
				GetCOListByTag('CheckedClicked').bRender = true;
				break;
			default:
				break;
		}

		ButtonState = NewButtonState;
	}
	else
	{
		GetCOListByTag('CheckedIdle').bRender = false;
		GetCOListByTag('CheckedHover').bRender = false;
		GetCOListByTag('CheckedClicked').bRender = false;

		super.SetButtonState(NewButtonState);
	}
}

/**
 * SetChecked
 * Declaration
 * Useful function to control the current state of the checkbox and the linked variable.
 * 
 * @param bNewChecked New state of the checkbox and a value of the linked bool variable.
 * @param bOnlyOneAction True if we want to simulate only one input action: press/release.
 * @param bPress True if the current action is a press, false if the current action is a release. Relevant only if bOnlyOneAction is true.
 */
function SetChecked(bool bNewChecked, optional bool bOnlyOneAction, optional bool bPress)
{
	if(bOnlyOneAction)
	{
		if(bPress)
		{
			if(bUsePressInsteadRelease)
			{
				bChecked = !bNewChecked;
			}
			PressButton();
		}
		else
		{
			if(!bUsePressInsteadRelease)
			{
				bChecked = !bNewChecked;
			}
			ReleaseButton();
		}
	}
	else
	{
		bChecked = !bNewChecked;
		ButtonActivated();
		SetButtonState(ButtonState);
	}
}

defaultproperties
{
	Begin Object Class=KISCanvasObjectList Name=COList_CheckedIdle
		Tag=CheckedIdle
		bRender=false
	End Object
	COList_CheckedIdle=COList_CheckedIdle

	Begin Object Class=KISCanvasObjectList Name=COList_CheckedHover
		Tag=CheckedHover
		bRender=false
	End Object
	COList_CheckedHover=COList_CheckedHover

	Begin Object Class=KISCanvasObjectList Name=COList_CheckedClicked
		Tag=CheckedClicked
		bRender=false
	End Object
	COList_CheckedClicked=COList_CheckedClicked
}
