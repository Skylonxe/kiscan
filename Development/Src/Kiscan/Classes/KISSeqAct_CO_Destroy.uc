/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_Destroy extends KISSequenceAction;

var(Target) string OwnerComponentTag;

var(Destroy) array<string> CanvasObjectTag;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;
	local KISCanvasObject CO;

	super.Activated();

	Comp = GetComponentByTag(name(OwnerComponentTag));
	
	if(Comp != none)
	{
		foreach CanvasObjectTag(FoundTag)
		{
			CO = Comp.GetCOByTag(name(FoundTag));

			if(CO != none)
			{
				CO.Destroy();
			}
		}
	}
}

defaultproperties
{
	ObjName="CO > Destroy"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Owner Component",PropertyName=OwnerComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Objects",PropertyName=CanvasObjectTag)
}


