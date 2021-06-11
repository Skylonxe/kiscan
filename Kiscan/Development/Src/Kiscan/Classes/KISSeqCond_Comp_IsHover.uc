/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqCond_Comp_IsHover extends KISSequenceCondition;

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

		if(Comp != none)
		{
			if(Comp.bMouseHover)
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
	ObjName="Comp > Is Hover"

	OutputLinks.Empty
	OutputLinks(0)=(LinkDesc="True")
	OutputLinks(1)=(LinkDesc="False")

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
}