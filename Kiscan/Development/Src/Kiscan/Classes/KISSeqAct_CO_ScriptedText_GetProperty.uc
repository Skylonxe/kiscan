/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_ScriptedText_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) string CanvasObjectTag;

var(Scripted_Text) editconst string Text;
var(Scripted_Text) editconst Object Font;
var(Scripted_Text) editconst int TextColorR;
var(Scripted_Text) editconst int TextColorG;
var(Scripted_Text) editconst int TextColorB;
var(Scripted_Text) editconst int TextColorA;
var(Scripted_Text) editconst bool bEnableShadow;
var(Scripted_Text) editconst bool bEnableLineBreaking;
var(Scripted_Text) editconst int LineLength;
var(Scripted_Text) editconst string NewLineCharacter;
var(Scripted_Text) editconst EKISTextAlign Alignment;
var int AlignmentIdx;

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
			Text = CO.Text;
			Font = CO.Font;
			TextColorR = CO.TextColor.R;
			TextColorG = CO.TextColor.G;
			TextColorB = CO.TextColor.B;
			TextColorA = CO.TextColor.A;
			bEnableShadow = CO.bEnableShadow;
			bEnableLineBreaking = CO.bEnableLineBreaking;
			LineLength = CO.LineLength;
			NewLineCharacter = CO.NewLineCharacter;
			AlignmentIdx = CO.Alignment;
			Alignment = EKISTextAlign(AlignmentIdx);
		}
	}
}

defaultproperties
{
	ObjName="CO > Scripted Text > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Object",PropertyName=CanvasObjectTag,MaxVars=1)

	VariableLinks(2)=(ExpectedType=class'SeqVar_String',LinkDesc="Text",PropertyName=Text,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="Font",PropertyName=Font,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color R",PropertyName=TextColorR,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color G",PropertyName=TextColorG,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color B",PropertyName=TextColorB,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color A",PropertyName=TextColorA,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enable Shadow",PropertyName=bEnableShadow,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enable Line Breaking",PropertyName=bEnableLineBreaking,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Int',LinkDesc="Line Length",PropertyName=LineLength,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_String',LinkDesc="New Line Character",PropertyName=NewLineCharacter,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Int',LinkDesc="Alignment",PropertyName=AlignmentIdx,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
