/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_GetOutputProperty extends KISSequenceAction;

var(Target) string ComponentTag;

var(Output_Property) editconst int OutputPositionX;
var(Output_Property) editconst int OutputPositionY;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}

function UpdateProperties(KISComponent Comp)
{
	if(Comp != none)
	{
		OutputPositionX = Comp.OutputPosition.X;
		OutputPositionY = Comp.OutputPosition.Y;
	}
}

defaultproperties
{
	ObjName="Comp > Get Output Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Pos X",PropertyName=OutputPositionX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Pos Y",PropertyName=OutputPositionY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
