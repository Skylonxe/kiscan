/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqCond_Comp_Button_SwitchState extends KISSequenceCondition;

var(Target) array<string> ComponentTag;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;
	local int Result;

	super.Activated();

	Result = -1;

	foreach ComponentTag(FoundTag)
	{
		Comp = GetComponentByTag(name(FoundTag));

		if(Comp != none && KISComponent_Button(Comp) != none)
		{
			switch(KISComponent_Button(Comp).ButtonState)
			{
				case BS_Idle:
					Result = 0;
					break;
				case BS_Hover:
					Result = 1;
					break;
				case BS_Clicked:
					Result = 2;
					break;
				default:
					break;
			}

			if(Result != -1)
			{
				break;
			}
		}
	}

	if(Result != -1)
	{
		ActivateOutputLink(Result);
	}
}


defaultproperties
{
	ObjName="Comp > Button > Switch State"

	OutputLinks.Empty
	OutputLinks(0)=(LinkDesc="Idle")
	OutputLinks(1)=(LinkDesc="Hover")
	OutputLinks(2)=(LinkDesc="Clicked")

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
}