/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_Checkbox_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;

var(Checkbox) editconst bool bDrawCheckedIdleUnderHover;
var(Checkbox) editconst bool bDrawCheckedIdleUnderClicked;
var(Checkbox) editconst bool bDrawCheckedHoverUnderClicked;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));

	if(Comp != none)
	{
		UpdateProperties(KISComponent_Button_Checkbox(Comp));
	}
}

function UpdateProperties(KISComponent_Button_Checkbox Comp)
{
	if(Comp != none)
	{
		bDrawCheckedIdleUnderHover = Comp.bDrawCheckedIdleUnderHover;
		bDrawCheckedIdleUnderClicked = Comp.bDrawCheckedIdleUnderClicked;
		bDrawCheckedHoverUnderClicked = Comp.bDrawCheckedHoverUnderClicked;
	}
}

defaultproperties
{
	ObjName="Comp > Button > Checkbox > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Checked Idle Under Hover",PropertyName=bDrawCheckedIdleUnderHover,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Checked Idle Under Clicked",PropertyName=bDrawCheckedIdleUnderClicked,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Checked Hover Under Clicked",PropertyName=bDrawCheckedHoverUnderClicked,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
