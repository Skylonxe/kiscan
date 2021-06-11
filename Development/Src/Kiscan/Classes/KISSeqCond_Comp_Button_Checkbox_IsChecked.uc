/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqCond_Comp_Button_Checkbox_IsChecked extends KISSequenceCondition;

var(Target) array<string> ComponentTag;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;
	local bool bResult;

	super.Activated();

	foreach ComponentTag(FoundTag)
	{
		Comp = GetComponentByTag(name(FoundTag));

		if(Comp != none && KISComponent_Button_Checkbox(Comp) != none)
		{
			if(KISComponent_Button_Checkbox(Comp).bChecked)
			{
				bResult = true;
				break;
			}
		}
	}

	if(bResult)
	{
		ActivateOutputLink(0);
	}
	else
	{
		ActivateOutputLink(1);
	}
}


defaultproperties
{
	ObjName="Comp > Button > Checkbox > Is Checked"

	OutputLinks.Empty
	OutputLinks(0)=(LinkDesc="True")
	OutputLinks(1)=(LinkDesc="False")

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
}