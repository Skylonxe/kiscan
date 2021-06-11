/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_SimulateInput extends KISSequenceAction;

var(Target) array<string> ComponentTag;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;

	super.Activated();

	foreach ComponentTag(FoundTag)
	{
		Comp = GetComponentByTag(name(FoundTag));

		if(Comp != none && KISComponent_Button(Comp) != none)
		{
			if(InputLinks[0].bHasImpulse)
			{
				KISComponent_Button(Comp).PressButton();
			}
			else if(InputLinks[1].bHasImpulse)
			{
				KISComponent_Button(Comp).ReleaseButton();
			}
		}
	}
	if(InputLinks[0].bHasImpulse)
	{
		ActivateOutputLink(0);
	}
	else if(InputLinks[0].bHasImpulse)
	{
		ActivateOutputLink(1);
	}
}

defaultproperties
{
	bAutoActivateOutputLinks=false

	ObjName="Comp > Button > Simulate Input"
	
	InputLinks(0)=(LinkDesc="Press")
	InputLinks(1)=(LinkDesc="Release")

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)

	OutputLinks(0)=(LinkDesc="Pressed")
	OutputLinks(1)=(LinkDesc="Released")
}