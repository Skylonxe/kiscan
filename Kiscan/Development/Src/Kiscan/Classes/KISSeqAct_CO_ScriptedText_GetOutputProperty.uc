/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_ScriptedText_GetOutputProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) string CanvasObjectTag;

var(Output_Property) editconst int OutputLengthOfLine;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}


function UpdateProperties(KISComponent Comp)
{
	local KISCanvasObject_ScriptedText CO;
	local KISCanvasObject COObj;

	if(Comp != none)
	{
		COObj = Comp.GetCOByTag(name(CanvasObjectTag));

		if(COObj != none)
		{
			CO = KISCanvasObject_ScriptedText(COObj);
		}
		
		if(CO != none)
		{
			OutputLengthOfLine = CO.OutputLengthOfLine;
		}
	}
}

defaultproperties
{
	ObjName="CO > Scripted Text > Get Output Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Object",PropertyName=CanvasObjectTag,MaxVars=1)

	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Length Of Line",PropertyName=OutputLengthOfLine,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
