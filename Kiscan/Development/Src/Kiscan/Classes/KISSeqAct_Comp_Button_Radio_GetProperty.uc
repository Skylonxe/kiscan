/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_Radio_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;

var(Radio) editconst bool bActiveRadioButton<DisplayName="Active">;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));

	if(Comp != none)
	{
		UpdateProperties(KISComponent_Button_Radio(Comp));
	}
}

function UpdateProperties(KISComponent_Button_Radio Comp)
{
	if(Comp != none)
	{
		bActiveRadioButton = Comp.bActive;
	}
}

defaultproperties
{
	ObjName="Comp > Button > Radio > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Active",PropertyName=bActiveRadioButton,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
