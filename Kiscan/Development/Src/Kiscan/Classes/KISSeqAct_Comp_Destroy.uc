/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Destroy extends KISSequenceAction;

var(Destroy) array<string> ComponentTag;

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
			Comp.Destroy();
		}
	}
}

defaultproperties
{
	ObjName="Comp > Destroy"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
}
