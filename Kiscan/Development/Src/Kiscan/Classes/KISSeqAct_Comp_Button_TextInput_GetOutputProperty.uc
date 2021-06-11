/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_TextInput_GetOutputProperty extends KISSequenceAction;

var(Target) string ComponentTag;

var(Output_Property) editconst float OutputScrollWindowSize;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));

	if(Comp != none)
	{
		UpdateProperties(KISComponent_Button_TextInput(Comp));
	}
}

function UpdateProperties(KISComponent_Button_TextInput Comp)
{
	if(Comp != none)
	{
		OutputScrollWindowSize = Comp.OutputScrollWindowSize;
	}
}

defaultproperties
{
	ObjName="Comp > Button > Text Input > Get Output Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Float',LinkDesc="Out Scroll Window Size",PropertyName=OutputScrollWindowSize,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
