/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_SimpleText_SetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) array<string> CanvasObjectTag;

var bool bUpdateText;
var(Simple_Text) string Text<EditCondition=bUpdateText|MultilineWithMaxRows=10>;
var bool bUpdateFont;
var(Simple_Text) Object Font<EditCondition=bUpdateFont>;
var bool bUpdateTextColorR;
var(Simple_Text) int TextColorR<EditCondition=bUpdateTextColorR|ClampMin=0|ClampMax=255>;
var bool bUpdateTextColorG;
var(Simple_Text) int TextColorG<EditCondition=bUpdateTextColorG|ClampMin=0|ClampMax=255>;
var bool bUpdateTextColorB;
var(Simple_Text) int TextColorB<EditCondition=bUpdateTextColorB|ClampMin=0|ClampMax=255>;
var bool bUpdateTextColorA;
var(Simple_Text) int TextColorA<EditCondition=bUpdateTextColorA|ClampMin=0|ClampMax=255>;
var bool bUpdateEnableShadow;
var(Simple_Text) bool bEnableShadow<EditCondition=bUpdateEnableShadow>;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}

function UpdateProperties(KISComponent Comp)
{
	local string FoundTag;
	local KISCanvasObject_SimpleText CO;
	local KISCanvasObject COObj;

	if(Comp != none)
	{
		foreach CanvasObjectTag(FoundTag)
		{
			COObj = Comp.GetCOByTag(name(FoundTag));

			if(COObj != none)
			{
				CO = KISCanvasObject_SimpleText(COObj);
			}

			if(CO != none)
			{
				if(bUpdateText)
				{
					CO.UpdateText(Text);
				}
				if(bUpdateFont)
				{
					CO.Font = Font(Font);
				}
				if(bUpdateTextColorR)
				{
					CO.TextColor.R = TextColorR;
				}
				if(bUpdateTextColorG)
				{
					CO.TextColor.G = TextColorG;
				}
				if(bUpdateTextColorB)
				{
					CO.TextColor.B = TextColorB;
				}
				if(bUpdateTextColorA)
				{
					CO.TextColor.A = TextColorA;
				}
				if(bUpdateEnableShadow)
				{
					CO.bEnableShadow = bEnableShadow;
				}

				CO.UpdateDynamicProperties();
			}
		}
	}
}

defaultproperties
{
	ObjName="CO > Simple Text > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Objects",PropertyName=CanvasObjectTag)

	VariableLinks(2)=(ExpectedType=class'SeqVar_String',LinkDesc="Text",PropertyName=Text,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="Font",PropertyName=Font,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color R",PropertyName=TextColorR,MaxVars=1,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color G",PropertyName=TextColorG,MaxVars=1,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color B",PropertyName=TextColorB,MaxVars=1,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color A",PropertyName=TextColorA,MaxVars=1,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enable Shadow",PropertyName=bEnableShadow,MaxVars=1,bHidden=true)
}