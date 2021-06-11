/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_Checkbox_SetProperty extends KISSequenceAction;

var(Target) array<string> ComponentTag;

var bool bUpdateDrawCheckedIdleUnderHover;
var(Checkbox) bool bDrawCheckedIdleUnderHover<EditCondition=bUpdateDrawCheckedIdleUnderHover>;
var bool bUpdateDrawCheckedIdleUnderClicked;
var(Checkbox) bool bDrawCheckedIdleUnderClicked<EditCondition=bUpdateDrawCheckedIdleUnderClicked>;
var bool bUpdateDrawCheckedHoverUnderClicked;
var(Checkbox) bool bDrawCheckedHoverUnderClicked<EditCondition=bUpdateDrawCheckedHoverUnderClicked>;

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
			UpdateProperties(KISComponent_Button_Checkbox(Comp));
		}
	}
}

function UpdateProperties(KISComponent_Button_Checkbox Comp)
{
	if(Comp != none)
	{
		if(bUpdateDrawCheckedIdleUnderHover)
		{
			Comp.bDrawCheckedIdleUnderHover = bDrawCheckedIdleUnderHover;
		}
		if(bUpdateDrawCheckedIdleUnderClicked)
		{
			Comp.bDrawCheckedIdleUnderClicked = bDrawCheckedIdleUnderClicked;
		}
		if(bUpdateDrawCheckedHoverUnderClicked)
		{
			Comp.bDrawCheckedHoverUnderClicked = bDrawCheckedHoverUnderClicked;
		}

		Comp.UpdateDynamicProperties();
	}
}

defaultproperties
{
	ObjName="Comp > Button > Checkbox > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Checked Idle Under Hover",PropertyName=bDrawCheckedIdleUnderHover,MaxVars=1,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Checked Idle Under Clicked",PropertyName=bDrawCheckedIdleUnderClicked,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Checked Hover Under Clicked",PropertyName=bDrawCheckedHoverUnderClicked,MaxVars=1,bHidden=true)
}