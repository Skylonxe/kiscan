/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Scene_SetProperty extends KISSequenceAction;

var(Target) array<string> SceneTag;

var bool bUpdatePositionDynamicX;
var(Basic_Appearance) int PositionDynamicX<EditCondition=bUpdatePositionDynamicX>;
var bool bUpdatePositionDynamicY;
var(Basic_Appearance) int PositionDynamicY<EditCondition=bUpdatePositionDynamicY>;
var bool bUpdatePositionRelativeX;
var(Basic_Appearance) float PositionRelativeX<EditCondition=bUpdatePositionRelativeX>;
var bool bUpdatePositionRelativeY;
var(Basic_Appearance) float PositionRelativeY<EditCondition=bUpdatePositionRelativeY>;
var bool bUpdatePositionOffsetX;
var(Basic_Appearance) int PositionOffsetX<EditCondition=bUpdatePositionOffsetX>;
var bool bUpdatePositionOffsetY;
var(Basic_Appearance) int PositionOffsetY<EditCondition=bUpdatePositionOffsetY>;

var bool bUpdateAttachToCursor;
var(Cursor) bool bAttachToCursor<EditCondition=bUpdateAttachToCursor>;
var bool bUpdateAttachToCursorOffsetDynamicX;
var(Cursor) int AttachToCursorOffsetDynamicX<EditCondition=bUpdateAttachToCursorOffsetDynamicX>;
var bool bUpdateAttachToCursorOffsetDynamicY;
var(Cursor) int AttachToCursorOffsetDynamicY<EditCondition=bUpdateAttachToCursorOffsetDynamicY>;
var bool bUpdateAttachToCursorOffsetRelativeX;
var(Cursor) float AttachToCursorOffsetRelativeX<EditCondition=bUpdateAttachToCursorOffsetRelativeX>;
var bool bUpdateAttachToCursorOffsetRelativeY;
var(Cursor) float AttachToCursorOffsetRelativeY<EditCondition=bUpdateAttachToCursorOffsetRelativeY>;
var bool bUpdateAttachToCursorOffsetOffsetX;
var(Cursor) int AttachToCursorOffsetOffsetX<EditCondition=bUpdateAttachToCursorOffsetOffsetX>;
var bool bUpdateAttachToCursorOffsetOffsetY;
var(Cursor) int AttachToCursorOffsetOffsetY<EditCondition=bUpdateAttachToCursorOffsetOffsetY>;

var bool bUpdateEnabled;
var(Rendering) bool bEnabled<EditCondition=bUpdateEnabled>;
var bool bUpdatePriority;
var(Rendering) int Priority<EditCondition=bUpdatePriority>;
var bool bUpdateDrawMode;
var(Rendering) EKISDrawMode DrawMode<EditCondition=bUpdateDrawMode>;
var int DrawModeIdx;
var bool bUpdateDrawShowAllMargin;
var(Rendering) bool bDrawShowAllMargin<EditCondition=bUpdateDrawShowAllMargin>;
var bool bUpdateShowAllMarginColorR;
var(Rendering) int ShowAllMarginColorR<EditCondition=bUpdateShowAllMarginColorR|ClampMin=0|ClampMax=255>;
var bool bUpdateShowAllMarginColorG;
var(Rendering) int ShowAllMarginColorG<EditCondition=bUpdateShowAllMarginColorG|ClampMin=0|ClampMax=255>;
var bool bUpdateShowAllMarginColorB;
var(Rendering) int ShowAllMarginColorB<EditCondition=bUpdateShowAllMarginColorB|ClampMin=0|ClampMax=255>;
var bool bUpdateShowAllMarginColorA;
var(Rendering) int ShowAllMarginColorA<EditCondition=bUpdateShowAllMarginColorA|ClampMin=0|ClampMax=255>;

event Activated()
{
	local string FoundTag;
	local KISScene Sce;

	super.Activated();

	foreach SceneTag(FoundTag)
	{
		Sce = GetSceneByTag(name(FoundTag));
		UpdateProperties(Sce);
	}
}

function UpdateProperties(KISScene Sce)
{
	local EKISDrawMode DM;

	if(Sce != none)
	{
		if(bUpdatePositionDynamicX)
		{
			Sce.Position.Dynamic.X = PositionDynamicX;
		}
		if(bUpdatePositionDynamicY)
		{
			Sce.Position.Dynamic.Y = PositionDynamicY;
		}
		if(bUpdatePositionRelativeX)
		{
			Sce.Position.Relative.X = PositionRelativeX;
		}
		if(bUpdatePositionRelativeY)
		{
			Sce.Position.Relative.Y = PositionRelativeY;
		}
		if(bUpdatePositionOffsetX)
		{
			Sce.Position.Offset.X = PositionOffsetX;
		}
		if(bUpdatePositionOffsetY)
		{
			Sce.Position.Offset.Y = PositionOffsetY;
		}
		if(bUpdateAttachToCursor)
		{
			Sce.bAttachToCursor = bAttachToCursor;
		}
		if(bUpdateAttachToCursorOffsetDynamicX)
		{
			Sce.AttachToCursorOffset.Dynamic.X = AttachToCursorOffsetDynamicX;
		}
		if(bUpdateAttachToCursorOffsetDynamicY)
		{
			Sce.AttachToCursorOffset.Dynamic.Y = AttachToCursorOffsetDynamicY;
		}
		if(bUpdateAttachToCursorOffsetRelativeX)
		{
			Sce.AttachToCursorOffset.Relative.X = AttachToCursorOffsetRelativeX;
		}
		if(bUpdateAttachToCursorOffsetRelativeY)
		{
			Sce.AttachToCursorOffset.Relative.Y = AttachToCursorOffsetRelativeY;
		}
		if(bUpdateAttachToCursorOffsetOffsetX)
		{
			Sce.AttachToCursorOffset.Offset.X = AttachToCursorOffsetOffsetX;
		}
		if(bUpdateAttachToCursorOffsetOffsetY)
		{
			Sce.AttachToCursorOffset.Offset.Y = AttachToCursorOffsetOffsetY;
		}
		if(bUpdateEnabled)
		{
			Sce.bEnabled = bEnabled;
		}
		if(bUpdatePriority)
		{
			Sce.SetPriority(Priority);
		}
		if(bUpdateDrawMode)
		{
			if(DrawModeIdx == -1)
			{
				DM = DrawMode;
			}
			else
			{
				DM = EKISDrawMode(Clamp(DrawModeIdx, 0, class'KISInfo'.static.GetEnumCount_EKISDrawMode() - 1));
			}

			Sce.DrawMode = DM;
		}
		if(bUpdateDrawShowAllMargin)
		{
			Sce.bDrawShowAllMargin = bDrawShowAllMargin;
		}
		if(bUpdateShowAllMarginColorR)
		{
			Sce.ShowAllMarginColor.R = ShowAllMarginColorR;
		}
		if(bUpdateShowAllMarginColorG)
		{
			Sce.ShowAllMarginColor.G = ShowAllMarginColorG;
		}
		if(bUpdateShowAllMarginColorB)
		{
			Sce.ShowAllMarginColor.B = ShowAllMarginColorB;
		}
		if(bUpdateShowAllMarginColorA)
		{
			Sce.ShowAllMarginColor.A = ShowAllMarginColorA;
		}
		
		Sce.UpdateDynamicProperties();
	}
}

defaultproperties
{
	ObjName="Scene > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Scenes",PropertyName=SceneTag)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Dynamic X",PropertyName=PositionDynamicX,MaxVars=1,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Dynamic Y",PropertyName=PositionDynamicY,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Float',LinkDesc="Position Relative X",PropertyName=PositionRelativeX,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Position Relative Y",PropertyName=PositionRelativeY,MaxVars=1,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Offset X",PropertyName=PositionOffsetX,MaxVars=1,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Position Offset Y",PropertyName=PositionOffsetY,MaxVars=1,bHidden=true)

	VariableLinks(7)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Attach To Cursor",PropertyName=bAttachToCursor,MaxVars=1,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn X",PropertyName=AttachToCursorOffsetDynamicX,MaxVars=1,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn Y",PropertyName=AttachToCursorOffsetDynamicY,MaxVars=1,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel X",PropertyName=AttachToCursorOffsetRelativeX,MaxVars=1,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel Y",PropertyName=AttachToCursorOffsetRelativeY,MaxVars=1,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off X",PropertyName=AttachToCursorOffsetOffsetX,MaxVars=1,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off Y",PropertyName=AttachToCursorOffsetOffsetY,MaxVars=1,bHidden=true)

	VariableLinks(14)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enabled",PropertyName=bEnabled,MaxVars=1,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Int',LinkDesc="Priority",PropertyName=Priority,MaxVars=1,bHidden=true)
	VariableLinks(16)=(ExpectedType=class'SeqVar_Int',LinkDesc="Draw Mode",PropertyName=DrawModeIdx,MaxVars=1,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Show All Margin",PropertyName=bDrawShowAllMargin,MaxVars=1,bHidden=true)
	VariableLinks(18)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color R",PropertyName=ShowAllMarginColorR,MaxVars=1,bHidden=true)
	VariableLinks(19)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color G",PropertyName=ShowAllMarginColorG,MaxVars=1,bHidden=true)
	VariableLinks(20)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color B",PropertyName=ShowAllMarginColorB,MaxVars=1,bHidden=true)
	VariableLinks(21)=(ExpectedType=class'SeqVar_Int',LinkDesc="Show All Margin Color A",PropertyName=ShowAllMarginColorA,MaxVars=1,bHidden=true)
 
	DrawModeIdx=-1
}