/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;

var(Button) editconst bool bDrawIdleUnderHover;
var(Button) editconst bool bDrawIdleUnderClicked;
var(Button) editconst bool bDrawHoverUnderClicked;

var(Button_Input) editconst bool bActivateByMouseButton;
var(Button_Input) editconst EKISMouseButton MouseButton;
var int MouseButtonIdx;
var(Button_Input) editconst array<string> KeyBind;
var(Button_Input) editconst bool bUsePressInsteadRelease;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));

	if(Comp != none)
	{
		UpdateProperties(KISComponent_Button(Comp));
	}
}

function UpdateProperties(KISComponent_Button Comp)
{
	local array<name> KeyBindName;
	local int i;

	if(Comp != none)
	{
		bDrawIdleUnderHover = Comp.bDrawIdleUnderHover;
		bDrawIdleUnderClicked = Comp.bDrawIdleUnderClicked;
		bDrawHoverUnderClicked = Comp.bDrawHoverUnderClicked;
		bActivateByMouseButton = Comp.bActivateByMouseButton;
		MouseButton = Comp.MouseButton;
		MouseButtonIdx = MouseButton;
		KeyBindName = Comp.KeyBind;
		for(i=0;i<KeyBindName.Length;i++)
		{
			KeyBind.AddItem(string(KeyBindName[i]));
		}
		bUsePressInsteadRelease = Comp.bUsePressInsteadRelease;
	}
}

defaultproperties
{
	ObjName="Comp > Button > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Idle Under Hover",PropertyName=bDrawIdleUnderHover,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Idle Under Clicked",PropertyName=bDrawIdleUnderClicked,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Hover Under Clicked",PropertyName=bDrawHoverUnderClicked,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Activate By Mouse Button",PropertyName=bActivateByMouseButton,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mouse Button",PropertyName=MouseButtonIdx,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_String',LinkDesc="Key Bind",PropertyName=KeyBind,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Use Press Instead Release",PropertyName=bUsePressInsteadRelease,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
