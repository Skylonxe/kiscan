/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_ScriptedText_SetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) array<string> CanvasObjectTag;

var bool bUpdateText;
var(Scripted_Text) string Text<EditCondition=bUpdateText|MultilineWithMaxRows=10>;
var bool bUpdateFont;
var(Scripted_Text) Object Font<EditCondition=bUpdateFont>;
var bool bUpdateTextColorR;
var(Scripted_Text) int TextColorR<EditCondition=bUpdateTextColorR|ClampMin=0|ClampMax=255>;
var bool bUpdateTextColorG;
var(Scripted_Text) int TextColorG<EditCondition=bUpdateTextColorG|ClampMin=0|ClampMax=255>;
var bool bUpdateTextColorB;
var(Scripted_Text) int TextColorB<EditCondition=bUpdateTextColorB|ClampMin=0|ClampMax=255>;
var bool bUpdateTextColorA;
var(Scripted_Text) int TextColorA<EditCondition=bUpdateTextColorA|ClampMin=0|ClampMax=255>;
var bool bUpdateEnableShadow;
var(Scripted_Text) bool bEnableShadow<EditCondition=bUpdateEnableShadow>;
var bool bUpdateEnableLineBreaking;
var(Scripted_Text) bool bEnableLineBreaking<EditCondition=bUpdateEnableLineBreaking>;
var bool bUpdateLineLength;
var(Scripted_Text) int LineLength<EditCondition=bUpdateLineLength|ClampMin=1>;
var bool bUpdateNewLineCharacter;
var(Scripted_Text) string NewLineCharacter<EditCondition=bUpdateNewLineCharacter>;
var bool bUpdateAlignment;
var(Scripted_Text) EKISTextAlign Alignment<EditCondition=bUpdateAlignment>;
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
	local string FoundTag;
	local KISCanvasObject_ScriptedText CO;
	local KISCanvasObject COObj;

	if(Comp != none)
	{
		foreach CanvasObjectTag(FoundTag)
		{
			COObj = Comp.GetCOByTag(name(FoundTag));

			if(COObj != none)
			{
				CO = KISCanvasObject_ScriptedText(COObj);
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
				if(bUpdateEnableLineBreaking)
				{
					CO.bEnableLineBreaking = bEnableLineBreaking;
				}
				if(bUpdateLineLength)
				{
					CO.LineLength = Max(LineLength, 1);
				}
				if(bUpdateNewLineCharacter)
				{
					CO.NewLineCharacter = NewLineCharacter;
				}
				if(bUpdateAlignment)
				{
					if(AlignmentIdx != -1)
					{
						CO.Alignment = EKISTextAlign(Clamp(AlignmentIdx, 0, class'KISInfo'.static.GetEnumCount_EKISTextAlign() - 1));
					}
					else
					{
						CO.Alignment = Alignment;
					}
				}

				CO.UpdateDynamicProperties();
			}
		}
	}
}

defaultproperties
{
	ObjName="CO > Scripted Text > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Objects",PropertyName=CanvasObjectTag)

	VariableLinks(2)=(ExpectedType=class'SeqVar_String',LinkDesc="Text",PropertyName=Text,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="Font",PropertyName=Font,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color R",PropertyName=TextColorR,MaxVars=1,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color G",PropertyName=TextColorG,MaxVars=1,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color B",PropertyName=TextColorB,MaxVars=1,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Text Color A",PropertyName=TextColorA,MaxVars=1,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enable Shadow",PropertyName=bEnableShadow,MaxVars=1,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enable Line Breaking",PropertyName=bEnableLineBreaking,MaxVars=1,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Int',LinkDesc="Line Length",PropertyName=LineLength,MaxVars=1,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_String',LinkDesc="New Line Character",PropertyName=NewLineCharacter,MaxVars=1,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Int',LinkDesc="Alignment",PropertyName=AlignmentIdx,MaxVars=1,bHidden=true)

	AlignmentIdx=-1
}