/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_SimpleText_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) string CanvasObjectTag;

var(Simple_Text) editconst string Text;
var(Simple_Text) editconst Object Font;
var(Simple_Text) editconst int TextColorR;
var(Simple_Text) editconst int TextColorG;
var(Simple_Text) editconst int TextColorB;
var(Simple_Text) editconst int TextColorA;
var(Simple_Text) editconst bool bEnableShadow;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}


function UpdateProperties(KISComponent Comp)
{
	local KISCanvasObject_SimpleText CO;
	local KISCanvasObject COObj;

	if(Comp != none)
	{
		COObj = Comp.GetCOByTag(name(CanvasObjectTag));

		if(COObj != none)
		{
			CO = KISCanvasObject_SimpleText(COObj);
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
		}
	}
}

defaultproperties
{
	ObjName="CO > Simple Text > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Object",PropertyName=CanvasObjectTag,MaxVars=1)

	VariableLinks(2)=(ExpectedType=class'SeqVar_String',LinkDesc="Text",PropertyName=Text,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="Font",PropertyName=Font,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color R",PropertyName=TextColorR,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color G",PropertyName=TextColorG,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color B",PropertyName=TextColorB,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color A",PropertyName=TextColorA,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enable Shadow",PropertyName=bEnableShadow,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
