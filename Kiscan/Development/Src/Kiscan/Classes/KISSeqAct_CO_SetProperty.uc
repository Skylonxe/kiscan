/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_SetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) array<string> CanvasObjectTag;

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

var bool bUpdateSizeX;
var(Basic_Appearance) float SizeX<EditCondition=bUpdateSizeX|ClampMin=0.0>;
var bool bUpdateSizeY;
var(Basic_Appearance) float SizeY<EditCondition=bUpdateSizeY|ClampMin=0.0>;
var bool bUpdateAnchorX;
var(Basic_Appearance) float AnchorX<EditCondition=bUpdateAnchorX|ClampMin=0.0|ClampMax=1.0>;
var bool bUpdateAnchorY;
var(Basic_Appearance) float AnchorY<EditCondition=bUpdateAnchorY|ClampMin=0.0|ClampMax=1.0>;

var bool bUpdateShapeEnabled;
var(Input_Shape) bool bShapeEnabled<EditCondition=bUpdateShapeEnabled>;
var bool bUpdateShape;
var(Input_Shape) EKISComponentShape Shape<EditCondition=bUpdateShape>;
var int ShapeIdx;
var bool bUpdateTransparentShape;
var(Input_Shape) bool bTransparentShape<EditCondition=bUpdateTransparentShape>;
var bool bUpdateAutoFitShape;
var(Input_Shape) bool bAutoFitShape<EditCondition=bUpdateAutoFitShape>;
var bool bUpdateShapePositionInCOX;
var(Input_Shape) float ShapePositionInCOX<DisplayName="Shape Position In CO X"|EditCondition=bUpdateShapePositionInCOX>;
var bool bUpdateShapePositionInCOY;
var(Input_Shape) float ShapePositionInCOY<DisplayName="Shape Position In CO Y"|EditCondition=bUpdateShapePositionInCOY>;
var bool bUpdateShapePositionOffsetDynamicX;
var(Input_Shape) int ShapePositionOffsetDynamicX<EditCondition=bUpdateShapePositionOffsetDynamicX>;
var bool bUpdateShapePositionOffsetDynamicY;
var(Input_Shape) int ShapePositionOffsetDynamicY<EditCondition=bUpdateShapePositionOffsetDynamicY>;
var bool bUpdateShapePositionOffsetRelativeX;
var(Input_Shape) float ShapePositionOffsetRelativeX<EditCondition=bUpdateShapePositionOffsetRelativeX>;
var bool bUpdateShapePositionOffsetRelativeY;
var(Input_Shape) float ShapePositionOffsetRelativeY<EditCondition=bUpdateShapePositionOffsetRelativeY>;
var bool bUpdateShapePositionOffsetOffsetX;
var(Input_Shape) int ShapePositionOffsetOffsetX<EditCondition=bUpdateShapePositionOffsetOffsetX>;
var bool bUpdateShapePositionOffsetOffsetY;
var(Input_Shape) int ShapePositionOffsetOffsetY<EditCondition=bUpdateShapePositionOffsetOffsetY>;
var bool bUpdateShapeSizeX;
var(Input_Shape) float ShapeSizeX<EditCondition=bUpdateShapeSizeX|ClampMin=0.0>;
var bool bUpdateShapeSizeY;
var(Input_Shape) float ShapeSizeY<EditCondition=bUpdateShapeSizeY|ClampMin=0.0>;
var bool bUpdateShapeAnchorX;
var(Input_Shape) float ShapeAnchorX<EditCondition=bUpdateShapeAnchorX|ClampMin=0.0|ClampMax=1.0>;
var bool bUpdateShapeAnchorY;
var(Input_Shape) float ShapeAnchorY<EditCondition=bUpdateShapeAnchorY|ClampMin=0.0|ClampMax=1.0>;

var bool bUpdateUseMask;
var(Mask) bool bUseMask<EditCondition=bUpdateUseMask>;
var bool bUpdateAttachMask;
var(Mask) bool bAttachMask<EditCondition=bUpdateAttachMask>;
var bool bUpdateMaskPositionInCOX;
var(Mask) float MaskPositionInCOX<DisplayName="Mask Position In CO X"|EditCondition=bUpdateMaskPositionInCOX>;
var bool bUpdateMaskPositionInCOY;
var(Mask) float MaskPositionInCOY<DisplayName="Mask Position In CO Y"|EditCondition=bUpdateMaskPositionInCOY>;
var bool bUpdateMaskPositionOffsetDynamicX;
var(Mask) int MaskPositionOffsetDynamicX<EditCondition=bUpdateMaskPositionOffsetDynamicX>;
var bool bUpdateMaskPositionOffsetDynamicY;
var(Mask) int MaskPositionOffsetDynamicY<EditCondition=bUpdateMaskPositionOffsetDynamicY>;
var bool bUpdateMaskPositionOffsetRelativeX;
var(Mask) float MaskPositionOffsetRelativeX<EditCondition=bUpdateMaskPositionOffsetRelativeX>;
var bool bUpdateMaskPositionOffsetRelativeY;
var(Mask) float MaskPositionOffsetRelativeY<EditCondition=bUpdateMaskPositionOffsetRelativeY>;
var bool bUpdateMaskPositionOffsetOffsetX;
var(Mask) int MaskPositionOffsetOffsetX<EditCondition=bUpdateMaskPositionOffsetOffsetX>;
var bool bUpdateMaskPositionOffsetOffsetY;
var(Mask) int MaskPositionOffsetOffsetY<EditCondition=bUpdateMaskPositionOffsetOffsetY>;
var bool bUpdateMaskSizeX;
var(Mask) float MaskSizeX<EditCondition=bUpdateMaskSizeX|ClampMin=0.0>;
var bool bUpdateMaskSizeY;
var(Mask) float MaskSizeY<EditCondition=bUpdateMaskSizeY|ClampMin=0.0>;
var bool bUpdateMaskAnchorX;
var(Mask) float MaskAnchorX<EditCondition=bUpdateMaskAnchorX|ClampMin=0.0|ClampMax=1.0>;
var bool bUpdateMaskAnchorY;
var(Mask) float MaskAnchorY<EditCondition=bUpdateMaskAnchorY|ClampMin=0.0|ClampMax=1.0>;

var bool bUpdateEnabled;
var(Rendering) bool bEnabled<EditCondition=bUpdateEnabled>;
var bool bUpdatePriority;
var(Rendering) int Priority<EditCondition=bUpdatePriority>;
var bool bUpdateUseResolutionLimit;
var(Rendering) bool bUseResolutionLimit<EditCondition=bUpdateUseResolutionLimit>;
var bool bUpdateResolutionLimitMinX;
var(Rendering) int ResolutionLimitMinY<EditCondition=bUpdateResolutionLimitMinX|ClampMin=1>;
var bool bUpdateResolutionLimitMaxY;
var(Rendering) int ResolutionLimitMaxY<EditCondition=bUpdateResolutionLimitMaxY|ClampMin=1>;

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
	local KISCanvasObject CO;

	if(Comp != none)
	{
		foreach CanvasObjectTag(FoundTag)
		{
			CO = Comp.GetCOByTag(name(FoundTag));

			if(CO != none)
			{
				if(bUpdatePositionDynamicX)
				{
					CO.Position.Dynamic.X = PositionDynamicX;
				}
				if(bUpdatePositionDynamicY)
				{
					CO.Position.Dynamic.Y = PositionDynamicY;
				}
				if(bUpdatePositionRelativeX)
				{
					CO.Position.Relative.X = PositionRelativeX;
				}
				if(bUpdatePositionRelativeY)
				{
					CO.Position.Relative.Y = PositionRelativeY;
				}
				if(bUpdatePositionOffsetX)
				{
					CO.Position.Offset.X = PositionOffsetX;
				}
				if(bUpdatePositionOffsetY)
				{
					CO.Position.Offset.Y = PositionOffsetY;
				}
				if(bUpdateSizeX)
				{
					CO.Size.X = FMax(SizeX, 0.f);
				}
				if(bUpdateSizeY)
				{
					CO.Size.Y = FMax(SizeY, 0.f);
				}
				if(bUpdateAnchorX)
				{
					CO.Anchor.X = FClamp(AnchorX, 0.f, 1.f);
				}
				if(bUpdateAnchorY)
				{
					CO.Anchor.Y = FClamp(AnchorY, 0.f, 1.f);
				}
				if(bUpdateShapeEnabled)
				{
					CO.bShapeEnabled = bShapeEnabled;
				}
				if(bUpdateShape)
				{
					if(ShapeIdx != -1)
					{
						CO.Shape = EKISComponentShape(Clamp(ShapeIdx, 0, class'KISInfo'.static.GetEnumCount_EKISComponentShape() - 1));
					}
					else
					{
						CO.Shape = Shape;
					}
				}
				if(bUpdateTransparentShape)
				{
					CO.bTransparentShape = bTransparentShape;
				}
				if(bUpdateAutoFitShape)
				{
					CO.bAutoFitShape = bAutoFitShape;
				}
				if(bUpdateShapePositionInCOX)
				{
					CO.ShapePositionInCO.X = ShapePositionInCOX;
				}
				if(bUpdateShapePositionInCOY)
				{
					CO.ShapePositionInCO.Y = ShapePositionInCOY;
				}
				if(bUpdateShapePositionOffsetDynamicX)
				{
					CO.ShapePositionOffset.Dynamic.X = ShapePositionOffsetDynamicX;
				}
				if(bUpdateShapePositionOffsetDynamicY)
				{
					CO.ShapePositionOffset.Dynamic.Y = ShapePositionOffsetDynamicY;
				}
				if(bUpdateShapePositionOffsetRelativeX)
				{
					CO.ShapePositionOffset.Relative.X = ShapePositionOffsetRelativeX;
				}
				if(bUpdateShapePositionOffsetRelativeY)
				{
					CO.ShapePositionOffset.Relative.Y = ShapePositionOffsetRelativeY;
				}
				if(bUpdateShapePositionOffsetOffsetX)
				{
					CO.ShapePositionOffset.Offset.X = ShapePositionOffsetOffsetX;
				}
				if(bUpdateShapePositionOffsetOffsetY)
				{
					CO.ShapePositionOffset.Offset.Y = ShapePositionOffsetOffsetY;
				}
				if(bUpdateShapeSizeX)
				{
					CO.ShapeSize.X = FMax(ShapeSizeX, 0.f);
				}
				if(bUpdateShapeSizeY)
				{
					CO.ShapeSize.Y = FMax(ShapeSizeY, 0.f);
				}
				if(bUpdateShapeAnchorX)
				{
					CO.ShapeAnchor.X = FClamp(ShapeAnchorX, 0.f, 1.f);
				}
				if(bUpdateShapeAnchorY)
				{
					CO.ShapeAnchor.Y = FClamp(ShapeAnchorY, 0.f, 1.f);
				}
				if(bUpdateUseMask)
				{
					CO.bUseMask = bUseMask;
				}
				if(bUpdateAttachMask)
				{
					CO.bAttachMask = bAttachMask;
				}
				if(bUpdateMaskPositionInCOX)
				{
					CO.MaskPositionInCO.X = MaskPositionInCOX;
				}
				if(bUpdateMaskPositionInCOY)
				{
					CO.MaskPositionInCO.Y = MaskPositionInCOY;
				}
				if(bUpdateMaskPositionOffsetDynamicX)
				{
					CO.MaskPositionOffset.Dynamic.X = MaskPositionOffsetDynamicX;
				}
				if(bUpdateMaskPositionOffsetDynamicY)
				{
					CO.MaskPositionOffset.Dynamic.Y = MaskPositionOffsetDynamicY;
				}
				if(bUpdateMaskPositionOffsetRelativeX)
				{
					CO.MaskPositionOffset.Relative.X = MaskPositionOffsetRelativeX;
				}
				if(bUpdateMaskPositionOffsetRelativeY)
				{
					CO.MaskPositionOffset.Relative.Y = MaskPositionOffsetRelativeY;
				}
				if(bUpdateMaskPositionOffsetOffsetX)
				{
					CO.MaskPositionOffset.Offset.X = MaskPositionOffsetOffsetX;
				}
				if(bUpdateMaskPositionOffsetOffsetY)
				{
					CO.MaskPositionOffset.Offset.Y = MaskPositionOffsetOffsetY;
				}
				if(bUpdateMaskSizeX)
				{
					CO.MaskSize.X = FMax(MaskSizeX, 0.f);
				}
				if(bUpdateMaskSizeY)
				{
					CO.MaskSize.Y = FMax(MaskSizeY, 0.f);
				}
				if(bUpdateMaskAnchorX)
				{
					CO.MaskAnchor.X = FClamp(MaskAnchorX, 0.f, 1.f);
				}
				if(bUpdateMaskAnchorY)
				{
					CO.MaskAnchor.Y = FClamp(MaskAnchorY, 0.f, 1.f);
				}
				if(bUpdateEnabled)
				{
					CO.bEnabled = bEnabled;
				}
				if(bUpdatePriority)
				{
					CO.SetPriority(Priority);
				}
				if(bUpdateUseResolutionLimit)
				{
					CO.bUseResolutionLimit = bUseResolutionLimit;
				}
				if(bUpdateResolutionLimitMinX)
				{
					CO.ResolutionLimitMinY = Max(ResolutionLimitMinY, 1);
				}
				if(bUpdateResolutionLimitMaxY)
				{	
					CO.ResolutionLimitMaxY = Max(ResolutionLimitMaxY, 1);
				}

				CO.UpdateDynamicProperties();
			}
		}
	}
}

defaultproperties
{
	ObjName="CO > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Objects",PropertyName=CanvasObjectTag)

	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn X",PropertyName=PositionDynamicX,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn Y",PropertyName=PositionDynamicY,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel X",PropertyName=PositionRelativeX,MaxVars=1,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel Y",PropertyName=PositionRelativeY,MaxVars=1,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off X",PropertyName=PositionOffsetX,MaxVars=1,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off Y",PropertyName=PositionOffsetY,MaxVars=1,bHidden=true)

	VariableLinks(8)=(ExpectedType=class'SeqVar_Float',LinkDesc="Size X",PropertyName=SizeX,MaxVars=1,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Float',LinkDesc="Size Y",PropertyName=SizeY,MaxVars=1,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Anchor X",PropertyName=AnchorX,MaxVars=1,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_Float',LinkDesc="Anchor Y",PropertyName=AnchorY,MaxVars=1,bHidden=true)

	VariableLinks(12)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Shape Enabled",PropertyName=bShapeEnabled,MaxVars=1,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape",PropertyName=ShapeIdx,MaxVars=1,bHidden=true)
	VariableLinks(14)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Transparent Shape",PropertyName=bTransparentShape,MaxVars=1,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Auto Fit Shape",PropertyName=bAutoFitShape,MaxVars=1,bHidden=true)
	VariableLinks(16)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos In CO X",PropertyName=ShapePositionInCOX,MaxVars=1,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos In CO Y",PropertyName=ShapePositionInCOY,MaxVars=1,bHidden=true)
	VariableLinks(18)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Dyn X",PropertyName=ShapePositionOffsetDynamicX,MaxVars=1,bHidden=true)
	VariableLinks(19)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Dyn Y",PropertyName=ShapePositionOffsetDynamicY,MaxVars=1,bHidden=true)
	VariableLinks(20)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos Offset Rel X",PropertyName=ShapePositionOffsetRelativeX,MaxVars=1,bHidden=true)
	VariableLinks(21)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Pos Offset Rel Y",PropertyName=ShapePositionOffsetRelativeY,MaxVars=1,bHidden=true)
	VariableLinks(22)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Off X",PropertyName=ShapePositionOffsetOffsetX,MaxVars=1,bHidden=true)
	VariableLinks(23)=(ExpectedType=class'SeqVar_Int',LinkDesc="Shape Pos Offset Off Y",PropertyName=ShapePositionOffsetOffsetY,MaxVars=1,bHidden=true)
	VariableLinks(24)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Size X",PropertyName=ShapeSizeX,MaxVars=1,bHidden=true)
	VariableLinks(25)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Size Y",PropertyName=ShapeSizeY,MaxVars=1,bHidden=true)
	VariableLinks(26)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Anchor X",PropertyName=ShapeAnchorX,MaxVars=1,bHidden=true)
	VariableLinks(27)=(ExpectedType=class'SeqVar_Float',LinkDesc="Shape Anchor Y",PropertyName=ShapeAnchorY,MaxVars=1,bHidden=true)

	VariableLinks(28)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Use Mask",PropertyName=bUseMask,MaxVars=1,bHidden=true)
	VariableLinks(29)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Attach Mask",PropertyName=bAttachMask,MaxVars=1,bHidden=true)
	VariableLinks(30)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos In CO X",PropertyName=MaskPositionInCOX,MaxVars=1,bHidden=true)
	VariableLinks(31)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos In CO Y",PropertyName=MaskPositionInCOY,MaxVars=1,bHidden=true)
	VariableLinks(32)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Dyn X",PropertyName=MaskPositionOffsetDynamicX,MaxVars=1,bHidden=true)
	VariableLinks(33)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Dyn Y",PropertyName=MaskPositionOffsetDynamicY,MaxVars=1,bHidden=true)
	VariableLinks(34)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos Offset Rel X",PropertyName=MaskPositionOffsetRelativeX,MaxVars=1,bHidden=true)
	VariableLinks(35)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Pos Offset Rel Y",PropertyName=MaskPositionOffsetRelativeY,MaxVars=1,bHidden=true)
	VariableLinks(36)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Off X",PropertyName=MaskPositionOffsetOffsetX,MaxVars=1,bHidden=true)
	VariableLinks(37)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mask Pos Offset Off Y",PropertyName=MaskPositionOffsetOffsetY,MaxVars=1,bHidden=true)
	VariableLinks(38)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Size X",PropertyName=MaskSizeX,MaxVars=1,bHidden=true)
	VariableLinks(39)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Size Y",PropertyName=MaskSizeY,MaxVars=1,bHidden=true)
	VariableLinks(40)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Anchor X",PropertyName=MaskAnchorX,MaxVars=1,bHidden=true)
	VariableLinks(41)=(ExpectedType=class'SeqVar_Float',LinkDesc="Mask Anchor Y",PropertyName=MaskAnchorY,MaxVars=1,bHidden=true)

	VariableLinks(42)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enabled",PropertyName=bEnabled,MaxVars=1,bHidden=true)
	VariableLinks(43)=(ExpectedType=class'SeqVar_Int',LinkDesc="Priority",PropertyName=Priority,MaxVars=1,bHidden=true)
	VariableLinks(44)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Use Resolution Limit",PropertyName=bUseResolutionLimit,MaxVars=1,bHidden=true)
	VariableLinks(45)=(ExpectedType=class'SeqVar_Int',LinkDesc="Res Limit MinY",PropertyName=ResolutionLimitMinY,MaxVars=1,bHidden=true)
	VariableLinks(46)=(ExpectedType=class'SeqVar_Int',LinkDesc="Res Limit MaxY",PropertyName=ResolutionLimitMaxY,MaxVars=1,bHidden=true)

	ShapeIdx=-1
}

