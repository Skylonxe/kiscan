/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_TextInput_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;

var(Text_Input) editconst string Text;
var(Text_Input) editconst float CaretBlinkSpeed;
var(Text_Input) editconst bool bScroll;
var(Text_Input) editconst int ScrollWindowSize;

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
		Text = Comp.Text;
		CaretBlinkSpeed = Comp.CaretBlinkSpeed;
		bScroll = Comp.bScroll;
		ScrollWindowSize = Comp.ScrollWindowSize;
	}
}

defaultproperties
{
	ObjName="Comp > Button > Text Input > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Text",PropertyName=Text,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Float',LinkDesc="Caret Blink Speed",PropertyName=CaretBlinkSpeed,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Scroll",PropertyName=bScroll,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Int',LinkDesc="Scroll Window Size",PropertyName=ScrollWindowSize,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
