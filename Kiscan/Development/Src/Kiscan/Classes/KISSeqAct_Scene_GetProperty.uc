/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Scene_GetProperty extends KISSequenceAction;

var(Target) string SceneTag;

var(Basic_Appearance) editconst int PositionDynamicX;
var(Basic_Appearance) editconst int PositionDynamicY;
var(Basic_Appearance) editconst float PositionRelativeX;
var(Basic_Appearance) editconst float PositionRelativeY;
var(Basic_Appearance) editconst int PositionOffsetX;
var(Basic_Appearance) editconst int PositionOffsetY;

var(Cursor) editconst bool bAttachToCursor;
var(Cursor) editconst int AttachToCursorOffsetDynamicX;
var(Cursor) editconst int AttachToCursorOffsetDynamicY;
var(Cursor) editconst float AttachToCursorOffsetRelativeX;
var(Cursor) editconst float AttachToCursorOffsetRelativeY;
var(Cursor) editconst int AttachToCursorOffsetOffsetX;
var(Cursor) editconst int AttachToCursorOffsetOffsetY;

var(Rendering) editconst bool bEnabled;
var(Rendering) editconst int Priority;
var(Rendering) editconst EKISDrawMode DrawMode;
var int DrawModeIdx;
var(Rendering) editconst bool bDrawShowAllMargin;
var(Rendering) editconst int ShowAllMarginColorR;
var(Rendering) editconst int ShowAllMarginColorG;
var(Rendering) editconst int ShowAllMarginColorB;
var(Rendering) editconst int ShowAllMarginColorA;


event Activated()
{
	super.Activated();

	UpdateProperties(GetSceneByTag(name(SceneTag)));
}

function UpdateProperties(KISScene Sce)
{
	if(Sce != none)
	{
		class'KISObject'.static.GetIndividualGUIPos(Sce.Position, PositionDynamicX, PositionDynamicY, PositionRelativeX, PositionRelativeY, PositionOffsetX, PositionOffsetY);

		bAttachToCursor = Sce.bAttachToCursor;
		class'KISObject'.static.GetIndividualGUIPos(Sce.AttachToCursorOffset, AttachToCursorOffsetDynamicX, AttachToCursorOffsetDynamicY, AttachToCursorOffsetRelativeX, AttachToCursorOffsetRelativeY, AttachToCursorOffsetOffsetX, AttachToCursorOffsetOffsetY);

		bEnabled = Sce.bEnabled;
		Priority = Sce.Priority;
		DrawModeIdx = Sce.GetDrawMode();	
		DrawMode = EKISDrawMode(DrawModeIdx);
		bDrawShowAllMargin = Sce.bDrawShowAllMargin;
		ShowAllMarginColorR = Sce.ShowAllMarginColor.R;
		ShowAllMarginColorG = Sce.ShowAllMarginColor.G;
		ShowAllMarginColorB = Sce.ShowAllMarginColor.B;
		ShowAllMarginColorA = Sce.ShowAllMarginColor.A;
	}
}

defaultproperties
{
	ObjName="Scene > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Scene",PropertyName=SceneTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Dynamic X",PropertyName=PositionDynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Dynamic Y",PropertyName=PositionDynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Float',LinkDesc="Position Relative X",PropertyName=PositionRelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Position Relative Y",PropertyName=PositionRelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Offset X",PropertyName=PositionOffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Offset Y",PropertyName=PositionOffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(7)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Attach To Cursor",PropertyName=bAttachToCursor,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn X",PropertyName=AttachToCursorOffsetDynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn Y",PropertyName=AttachToCursorOffsetDynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel X",PropertyName=AttachToCursorOffsetRelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel Y",PropertyName=AttachToCursorOffsetRelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off X",PropertyName=AttachToCursorOffsetOffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off Y",PropertyName=AttachToCursorOffsetOffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(14)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enabled",PropertyName=bEnabled,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Int',LinkDesc="Priority",PropertyName=Priority,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(16)=(ExpectedType=class'SeqVar_Int',LinkDesc="Draw Mode",PropertyName=DrawModeIdx,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Show All Margin",PropertyName=bDrawShowAllMargin,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(18)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color R",PropertyName=ShowAllMarginColorR,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(19)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color G",PropertyName=ShowAllMarginColorG,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(20)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color B",PropertyName=ShowAllMarginColorB,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(21)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color A",PropertyName=ShowAllMarginColorA,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}