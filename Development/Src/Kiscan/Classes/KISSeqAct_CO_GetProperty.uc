/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) string CanvasObjectTag;

var(Basic_Appearance) editconst int PositionDynamicX;
var(Basic_Appearance) editconst int PositionDynamicY;
var(Basic_Appearance) editconst float PositionRelativeX;
var(Basic_Appearance) editconst float PositionRelativeY;
var(Basic_Appearance) editconst int PositionOffsetX;
var(Basic_Appearance) editconst int PositionOffsetY;
var(Basic_Appearance) editconst float SizeX;
var(Basic_Appearance) editconst float SizeY;
var(Basic_Appearance) editconst float AnchorX;
var(Basic_Appearance) editconst float AnchorY;

var(Input_Shape) editconst bool bShapeEnabled;
var(Input_Shape) editconst EKISComponentShape Shape;
var int ShapeIdx;
var(Input_Shape) editconst bool bTransparentShape;
var(Input_Shape) editconst bool bAutoFitShape;
var(Input_Shape) editconst float ShapePositionInCOX<DisplayName="Shape Position In CO X">;
var(Input_Shape) editconst float ShapePositionInCOY<DisplayName="Shape Position In CO Y">;
var(Input_Shape) editconst int ShapePositionOffsetDynamicX;
var(Input_Shape) editconst int ShapePositionOffsetDynamicY;
var(Input_Shape) editconst float ShapePositionOffsetRelativeX;
var(Input_Shape) editconst float ShapePositionOffsetRelativeY;
var(Input_Shape) editconst int ShapePositionOffsetOffsetX;
var(Input_Shape) editconst int ShapePositionOffsetOffsetY;
var(Input_Shape) editconst float ShapeSizeX;
var(Input_Shape) editconst float ShapeSizeY;
var(Input_Shape) editconst float ShapeAnchorX;
var(Input_Shape) editconst  float ShapeAnchorY;

var(Mask) editconst bool bUseMask;
var(Mask) editconst bool bAttachMask;
var(Mask) editconst float MaskPositionInCOX<DisplayName="Mask Position In CO X">;
var(Mask) editconst float MaskPositionInCOY<DisplayName="Mask Position In CO Y">;
var(Mask) editconst int MaskPositionOffsetDynamicX;
var(Mask) editconst int MaskPositionOffsetDynamicY;
var(Mask) editconst float MaskPositionOffsetRelativeX;
var(Mask) editconst float MaskPositionOffsetRelativeY;
var(Mask) editconst int MaskPositionOffsetOffsetX;
var(Mask) editconst int MaskPositionOffsetOffsetY;
var(Mask) editconst float MaskSizeX;
var(Mask) editconst float MaskSizeY;
var(Mask) editconst float MaskAnchorX;
var(Mask) editconst float MaskAnchorY;

var(Rendering) editconst bool bEnabled;
var(Rendering) editconst int Priority;
var(Rendering) editconst bool bUseResolutionLimit;
var(Rendering) editconst int ResolutionLimitMinY;
var(Rendering) editconst int ResolutionLimitMaxY;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}

function UpdateProperties(KISComponent Comp)
{
	local KISCanvasObject CO;

	if(Comp != none)
	{
		CO = Comp.GetCOByTag(name(CanvasObjectTag));

		if(CO != none)
		{
			class'KISObject'.static.GetIndividualGUIPos(CO.Position, PositionDynamicX, PositionDynamicY, PositionRelativeX, PositionRelativeY, PositionOffsetX, PositionOffsetY);
			SizeX = CO.Size.X;
			SizeY = CO.Size.Y;
			AnchorX = CO.Anchor.X;
			AnchorY = CO.Anchor.Y;

			bShapeEnabled = CO.bShapeEnabled;
			ShapeIdx = CO.Shape;
			Shape = EKISComponentShape(ShapeIdx);
			bTransparentShape = CO.bTransparentShape;
			bAutoFitShape = CO.bAutoFitShape;
			ShapePositionInCOX = CO.ShapePositionInCO.X;
			ShapePositionInCOY = CO.ShapePositionInCO.Y;
			class'KISObject'.static.GetIndividualGUIPos(CO.ShapePositionOffset, ShapePositionOffsetDynamicX, ShapePositionOffsetDynamicY, ShapePositionOffsetRelativeX, ShapePositionOffsetRelativeY, ShapePositionOffsetOffsetX, ShapePositionOffsetOffsetY);
			ShapeSizeX = CO.ShapeSize.X;
			ShapeSizeY = CO.ShapeSize.Y;
			ShapeAnchorX = CO.ShapeAnchor.X;
			ShapeAnchorY = CO.ShapeAnchor.Y;

			bUseMask = CO.bUseMask;
			bAttachMask = CO.bAttachMask;
			MaskPositionInCOX = CO.MaskPositionInCO.X;
			MaskPositionInCOY = CO.MaskPositionInCO.Y;
			class'KISObject'.static.GetIndividualGUIPos(CO.MaskPositionOffset, MaskPositionOffsetDynamicX, MaskPositionOffsetDynamicY, MaskPositionOffsetRelativeX, MaskPositionOffsetRelativeY, MaskPositionOffsetOffsetX, MaskPositionOffsetOffsetY);
			MaskSizeX = CO.MaskSize.X;
			MaskSizeY = CO.MaskSize.Y;
			MaskAnchorX = CO.MaskAnchor.X;
			MaskAnchorY = CO.MaskAnchor.Y;

			bEnabled = CO.bEnabled;
			Priority = CO.Priority;
			bUseResolutionLimit = CO.bUseResolutionLimit;
			ResolutionLimitMinY = CO.ResolutionLimitMinY;
			ResolutionLimitMaxY = CO.ResolutionLimitMaxY;
		}
	}
}

defaultproperties
{
	ObjName="CO > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Object",PropertyName=CanvasObjectTag,MaxVars=1)

	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn X",PropertyName=PositionDynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn Y",PropertyName=PositionDynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel X",PropertyName=PositionRelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel Y",PropertyName=PositionRelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off X",PropertyName=PositionOffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off Y",PropertyName=PositionOffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(8)=(ExpectedType=class'SeqVar_Float',LinkDesc="Size X",PropertyName=SizeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Float',LinkDesc="Size Y",PropertyName=SizeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Anchor X",PropertyName=AnchorX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_Float',LinkDesc="Anchor Y",PropertyName=AnchorY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(12)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Shape Enabled",PropertyName=bShapeEnabled,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape",PropertyName=ShapeIdx,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(14)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Transparent Shape",PropertyName=bTransparentShape,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Auto Fit Shape",PropertyName=bAutoFitShape,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(16)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos In CO X",PropertyName=ShapePositionInCOX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos In CO Y",PropertyName=ShapePositionInCOY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(18)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Dyn X",PropertyName=ShapePositionOffsetDynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(19)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Dyn Y",PropertyName=ShapePositionOffsetDynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(20)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos Offset Rel X",PropertyName=ShapePositionOffsetRelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(21)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos Offset Rel Y",PropertyName=ShapePositionOffsetRelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(22)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Off X",PropertyName=ShapePositionOffsetOffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(23)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Off Y",PropertyName=ShapePositionOffsetOffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(24)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Size X",PropertyName=ShapeSizeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(25)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Size Y",PropertyName=ShapeSizeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(26)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Anchor X",PropertyName=ShapeAnchorX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(27)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Anchor Y",PropertyName=ShapeAnchorY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(28)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Use Mask",PropertyName=bUseMask,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(29)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Attach Mask",PropertyName=bAttachMask,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(30)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos In CO X",PropertyName=MaskPositionInCOX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(31)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos In CO Y",PropertyName=MaskPositionInCOY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(32)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Dyn X",PropertyName=MaskPositionOffsetDynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(33)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Dyn Y",PropertyName=MaskPositionOffsetDynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(34)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos Offset Rel X",PropertyName=MaskPositionOffsetRelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(35)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos Offset Rel Y",PropertyName=MaskPositionOffsetRelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(36)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Off X",PropertyName=MaskPositionOffsetOffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(37)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Off Y",PropertyName=MaskPositionOffsetOffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(38)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Size X",PropertyName=MaskSizeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(39)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Size Y",PropertyName=MaskSizeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(40)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Anchor X",PropertyName=MaskAnchorX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(41)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Anchor Y",PropertyName=MaskAnchorY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(42)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enabled",PropertyName=bEnabled,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(43)=(ExpectedType=class'SeqVar_Int',LinkDesc="Priority",PropertyName=Priority,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(44)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Use Resolution Limit",PropertyName=bUseResolutionLimit,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(45)=(ExpectedType=class'SeqVar_Int',LinkDesc="Res Limit MinY",PropertyName=ResolutionLimitMinY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(46)=(ExpectedType=class'SeqVar_Int',LinkDesc="Res Limit MaxY",PropertyName=ResolutionLimitMaxY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
