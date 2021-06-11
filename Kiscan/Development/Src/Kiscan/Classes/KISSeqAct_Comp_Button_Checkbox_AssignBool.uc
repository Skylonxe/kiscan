/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_Checkbox_AssignBool extends KISSequenceAction;

var(Target) array<string> ComponentTag;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;
	local SeqVar_Bool BoolVar;

	super.Activated();

	foreach LinkedVariables(class'SeqVar_Bool', BoolVar, "Bool Var")
	{
		foreach ComponentTag(FoundTag)
		{
			Comp = GetComponentByTag(name(FoundTag));

			if(Comp != none && KISComponent_Button_Checkbox(Comp) != none)
			{
				KISComponent_Button_Checkbox(Comp).AssignedBool = BoolVar;
			}
		}

		break;
	}
}

defaultproperties
{
	ObjName="Comp > Button > Checkbox > Assign Bool"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Bool Var",MaxVars=1)
}