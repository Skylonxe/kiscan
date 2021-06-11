/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_Radio_AssignInt extends KISSequenceAction;

var(Target) array<string> ComponentTag;
var(Target) string RadioGroupName;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;
	local SeqVar_Int IntVar;
	local int Idx;

	super.Activated();

	if(RadioGroupName != "")
	{
		foreach LinkedVariables(class'SeqVar_Int', IntVar, "Int Var")
		{
			foreach ComponentTag(FoundTag, Idx)
			{
				Comp = GetComponentByTag(name(FoundTag));

				if(Comp != none && KISComponent_Button_Radio(Comp) != none)
				{
					KISComponent_Button_Radio(Comp).AssignedInt = IntVar;
					KISComponent_Button_Radio(Comp).RadioGroup = name(RadioGroupName);
					KISComponent_Button_Radio(Comp).Index = Idx;
				}
			}

			break;
		}
	}
}

defaultproperties
{
	ObjName="Comp > Button > Radio > Assign Int"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Radio Group Name",PropertyName=RadioGroupName,MaxVars=1)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Int Var",MaxVars=1)
}