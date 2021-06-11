/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_TextInput_SetProperty extends KISSequenceAction;

var(Target) array<string> ComponentTag;

var bool bUpdateText;
var(Text_Input) string Text<EditCondition=bUpdateText|MultilineWithMaxRows=10>;
var bool bUpdateCaretBlinkSpeed;
var(Text_Input) float CaretBlinkSpeed<EditCondition=bUpdateCaretBlinkSpeed|ClampMin=0.0>;
var bool bUpdateScroll;
var(Text_Input) bool bScroll<EditCondition=bUpdateScroll>;
var bool bUpdateScrollWindowSize;
var(Text_Input) int ScrollWindowSize<EditCondition=bUpdateScrollWindowSize|ClampMin=1>;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;

	super.Activated();

	foreach ComponentTag(FoundTag)
	{
		Comp = GetComponentByTag(name(FoundTag));

		if(Comp != none)
		{
			UpdateProperties(KISComponent_Button_TextInput(Comp));
		}
	}
}

function UpdateProperties(KISComponent_Button_TextInput Comp)
{
	if(Comp != none)
	{
		if(bUpdateText)
		{
			Comp.SetText(Text);
		}
		if(bUpdateCaretBlinkSpeed)
		{
			Comp.CaretBlinkSpeed = FMax(CaretBlinkSpeed, 0.f);
		}
		if(bUpdateScroll)
		{
			Comp.bScroll = bScroll;
		}
		if(bUpdateScrollWindowSize)
		{
			Comp.ScrollWindowSize = Max(ScrollWindowSize, 1);
		}

		Comp.UpdateDynamicProperties();
	}
}

defaultproperties
{
	ObjName="Comp > Button > Text Input > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)

	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Text",PropertyName=Text,MaxVars=1,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Float',LinkDesc="Caret Blink Speed",PropertyName=CaretBlinkSpeed,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Scroll",PropertyName=bScroll,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Int',LinkDesc="Scroll Window Size",PropertyName=ScrollWindowSize,MaxVars=1,bHidden=true)
}