/**
 * Kiscan GUI Framework
 * 
 * KISComponent_Button_Radio
 * 
 * Radio button is the button which is in a group with other radio buttons
 * but only one can be activated at the moment.
 * It is linked to the int variable which controls by indexes of buttons which button is pressed.
 * Usually we link it with the kismet int variable however we can redirect it using delegates if needed.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISComponent_Button_Radio extends KISComponent_Button;

/** This list is rendered when this radio button is one which is activated. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectList COList_ActiveIdle<DisplayName="CO List - Active Idle">;

/** Name of the group if which this button is. Radio buttons are grouped because it is easier to call kismet events then.
 *  Group is set via the kismet action AssignInt. */
var name RadioGroup;
/** Index of this button. Every radio buttton in the group has different index. */
var int Index;

/** True if this button is one which is activated. */
var bool bActive;

/** Linked kismet int variable. */
var SeqVar_Int AssignedInt;

/**
 * GetIntValue
 * Declaration
 * Give ability to link to some other variable in code.
 * Defaultly it looks for the linked kismet variable.
 * 
 * @return Current value of the linked int variable.
 */
delegate int GetIntValue()
{
	local int Result;

	if(AssignedInt != none)
	{
		Result = AssignedInt.IntValue;
	}

	return Result;
}

/**
 * SetIntValue
 * Declaration
 * Give ability to link to some other variable in code.
 * Defaultly it looks for the linked kismet variable.
 * 
 * @param NewValue Requested value of linked int variable.
 */
delegate SetIntValue(int NewValue)
{
	if(AssignedInt != none)
	{
		AssignedInt.IntValue = NewValue;
	}
}

/**
 * LoadCOLists
 * Override
 */
function LoadCOLists()
{
	super.LoadCOLists();

	COLists.AddItem(COList_ActiveIdle);
}

/**
 * Update
 * Override
 */
function Update(float DeltaTime)
{
	super.Update(DeltaTime);

	CheckAssigendIntMatch();
}

/**
 * CheckAssignedIntMatch
 * Declaration
 * Check the state of the radio button. Activate it if needed.
 * */
function CheckAssigendIntMatch()
{
	if((GetIntValue() == Index) != bActive)
	{
		SetActive(GetIntValue() == Index, true);
	}
}

/**
 * ButtonActivated
 * Override
 */
function ButtonActivated()
{
	bActive = true;
	SetIntValue(Index);

	super.ButtonActivated();

	HUD.TriggerGlobalTagEvent(class'KISSeqEvent_Comp_Button_Radio_Changed', RadioGroup);
}

/**
 * DeactivateButton
 * Declaration
 * Called when the button is active and we want to deactivate it.
 */
function DeactivateButton()
{
	bActive = false;
	SetButtonState(ButtonState);
}

/**
 * SetButtonState
 * Override
 */
function SetButtonState(EKISButtonState NewButtonState)
{
	if(bActive)
	{
		GetCOListByTag('Idle').bRender = false;
		GetCOListByTag('Hover').bRender = false;
		GetCOListByTag('Clicked').bRender = false;

		GetCOListByTag('ActiveIdle').bRender = true;

		ButtonState = BS_Idle;
	}
	else
	{
		GetCOListByTag('ActiveIdle').bRender = false;

		super.SetButtonState(NewButtonState);
	}
}

/**
 * SetActive
 * Declaration
 * Useful fuction to control state of button and linked variable.
 * 
 * @param bNewActive New state of the radio button and a value of the linked int variable.
 * @param bOnlyOneAction True if we want to simulate only one input action: press/release.
 * @param bPress True if the current action is a press, false if the current action is a release. Relevant only if bOnlyOneAction is true.
 */
function SetActive(bool bNewActive, optional bool bOnlyOneAction, optional bool bPress)
{
	if(bNewActive)
	{
		if(bOnlyOneAction)
		{
			if(bPress)
			{
				PressButton();
			}
			else
			{
				ReleaseButton();
			}
		}
		else
		{
			ButtonActivated();
			SetButtonState(ButtonState);
		}
	}
	else
	{
		DeactivateButton();
	}
}

defaultproperties
{
	Begin Object Class=KISCanvasObjectList Name=COList_ActiveIdle
		Tag=ActiveIdle
		bRender=false
	End Object
	COList_ActiveIdle=COList_ActiveIdle

	Index=-1
}