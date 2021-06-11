/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_Image_SetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) array<string> CanvasObjectTag;

var bool bUpdateImageType;
var(Image) EKISImageType ImageType<EditCondition=bUpdateImageType>;
var int ImageTypeIdx;

var bool bUpdateMaterial;
var(Image_Material) Object Material<EditCondition=bUpdateMaterial>;
var bool bUpdateUVCoordsNormalizedU;
var(Image_Material) float UVCoordsNormalizedU<EditCondition=bUpdateUVCoordsNormalizedU>;
var bool bUpdateUVCoordsNormalizedV;
var(Image_Material) float UVCoordsNormalizedV<EditCondition=bUpdateUVCoordsNormalizedV>;
var bool bUpdateUVCoordsNormalizedUL;
var(Image_Material) float UVCoordsNormalizedUL<EditCondition=bUpdateUVCoordsNormalizedUL>;
var bool bUpdateUVCoordsNormalizedVL;
var(Image_Material) float UVCoordsNormalizedVL<EditCondition=bUpdateUVCoordsNormalizedVL>;
var bool bUpdateMaterialRotationYaw;
var(Image_Material) float MaterialRotationYaw<EditCondition=bUpdateMaterialRotationYaw|ClampMin=0.0|ClampMax=360.0>;
var bool bUpdateMaterialRotationAnchorX;
var(Image_Material) float MaterialRotationAnchorX<EditCondition=bUpdateMaterialRotationAnchorX>;
var bool bUpdateMaterialRotationAnchorY;
var(Image_Material) float MaterialRotationAnchorY<EditCondition=bUpdateMaterialRotationAnchorY>;

var bool bUpdateTextureMode;
var(Image_Texture) EKISTextureMode TextureMode<EditCondition=bUpdateTextureMode>;
var int TextureModeIdx;
var bool bUpdateTexture;
var(Image_Texture) Object Texture<EditCondition=bUpdateTexture>;
var bool bUpdateTextureColorR;
var(Image_Texture) int TextureColorR<EditCondition=bUpdateTextureColorR|ClampMin=0|ClampMax=255>;
var bool bUpdateTextureColorG;
var(Image_Texture) int TextureColorG<EditCondition=bUpdateTextureColorG|ClampMin=0|ClampMax=255>;
var bool bUpdateTextureColorB;
var(Image_Texture) int TextureColorB<EditCondition=bUpdateTextureColorB|ClampMin=0|ClampMax=255>;
var bool bUpdateTextureColorA;
var(Image_Texture) int TextureColorA<EditCondition=bUpdateTextureColorA|ClampMin=0|ClampMax=255>;
var bool bUpdateUVCoordsU;
var(Image_Texture) int UVCoordsU<EditCondition=bUpdateUVCoordsU>;
var bool bUpdateUVCoordsV;
var(Image_Texture) int UVCoordsV<EditCondition=bUpdateUVCoordsV>;
var bool bUpdateUVCoordsUL;
var(Image_Texture) int UVCoordsUL<EditCondition=bUpdateUVCoordsUL>;
var bool bUpdateUVCoordsVL;
var(Image_Texture) int UVCoordsVL<EditCondition=bUpdateUVCoordsVL>;

var bool bUpdateTextureBlendMode;
var(Image_Texture_Normal) EBlendMode TextureBlendMode<EditCondition=bUpdateTextureBlendMode>;
var int TextureBlendModeIdx;

var bool bUpdateTextureRotationYaw;
var(Image_Texture_Rotated) float TextureRotationYaw<EditCondition=bUpdateTextureRotationYaw|ClampMin=0.0|ClampMax=360.0>;
var bool bUpdateTextureRotationAnchorX;
var(Image_Texture_Rotated) float TextureRotationAnchorX<EditCondition=bUpdateTextureRotationAnchorX>;
var bool bUpdateTextureRotationAnchorY;
var(Image_Texture_Rotated) float TextureRotationAnchorY<EditCondition=bUpdateTextureRotationAnchorY>;

var bool bUpdateStretchHorizontally;
var(Image_Texture_Stretched) bool bStretchHorizontally<EditCondition=bUpdateStretchHorizontally>;
var bool bUpdateStretchVertically;
var(Image_Texture_Stretched) bool bStretchVertically<EditCondition=bUpdateStretchVertically>;
var bool bUpdateStretchScalingFactor;
var(Image_Texture_Stretched) float StretchScalingFactor<EditCondition=bUpdateStretchScalingFactor|ClampMin=0.0|ClampMax=1.0>;

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
	local KISCanvasObject_Image CO;
	local KISCanvasObject COObj;

	if(Comp != none)
	{
		foreach CanvasObjectTag(FoundTag)
		{
			COObj = Comp.GetCOByTag(name(FoundTag));

			if(COObj != none)
			{
				CO = KISCanvasObject_Image(COObj);
			}

			if(CO != none)
			{
				if(bUpdateImageType)
				{
					if(ImageTypeIdx != -1)
					{
						CO.ImageType = EKISImageType(Clamp(ImageTypeIdx, 0, class'KISInfo'.static.GetEnumCount_EKISImageType()));
					}
					else
					{
						CO.ImageType = ImageType;
					}
				}
				if(bUpdateMaterial)
				{
					CO.Material = MaterialInterface(Material);
				}
				if(bUpdateUVCoordsNormalizedU)
				{
					CO.UVCoordsNormalized.U = UVCoordsNormalizedU;
				}
				if(bUpdateUVCoordsNormalizedV)
				{
					CO.UVCoordsNormalized.V = UVCoordsNormalizedV;
				}
				if(bUpdateUVCoordsNormalizedUL)
				{
					CO.UVCoordsNormalized.UL = UVCoordsNormalizedUL;
				}
				if(bUpdateUVCoordsNormalizedVL)
				{
					CO.UVCoordsNormalized.VL = UVCoordsNormalizedVL;
				}
				if(bUpdateMaterialRotationYaw)
				{
					CO.MaterialRotationYaw = MaterialRotationYaw;
				}
				if(bUpdateMaterialRotationAnchorX)
				{
					CO.MaterialRotationAnchor.X = MaterialRotationAnchorX;
				}
				if(bUpdateMaterialRotationAnchorY)
				{
					CO.MaterialRotationAnchor.Y = MaterialRotationAnchorY;
				}
				if(bUpdateTextureMode)
				{
					if(TextureModeIdx != -1)
					{
						CO.TextureMode = EKISTextureMode(Clamp(TextureModeIdx, 0, class'KISInfo'.static.GetEnumCount_EKISTextureMode() - 1));
					}
					else
					{
						CO.TextureMode = TextureMode;
					}
				}
				if(bUpdateTexture)
				{
					CO.Texture = Texture(Texture);
				}
				if(bUpdateTextureColorR)
				{
					CO.TextureColor.R = TextureColorR;
				}
				if(bUpdateTextureColorG)
				{
					CO.TextureColor.G = TextureColorG;
				}
				if(bUpdateTextureColorB)
				{
					CO.TextureColor.B = TextureColorB;
				}
				if(bUpdateTextureColorA)
				{
					CO.TextureColor.A = TextureColorA;
				}
				if(bUpdateUVCoordsU)
				{
					CO.UVCoords.U = UVCoordsU;
				}
				if(bUpdateUVCoordsV)
				{
					CO.UVCoords.V = UVCoordsV;
				}
				if(bUpdateUVCoordsUL)
				{
					CO.UVCoords.UL = UVCoordsUL;
				}
				if(bUpdateUVCoordsVL)
				{
					CO.UVCoords.VL = UVCoordsVL;
				}
				if(bUpdateTextureBlendMode)
				{
					if(TextureBlendModeIdx != -1)
					{
						CO.TextureBlendMode = EBlendMode(Clamp(TextureBlendModeIdx, 0, 8));
					}
					else
					{
						CO.TextureBlendMode = TextureBlendMode;
					}
				}
				if(bUpdateTextureRotationYaw)
				{
					CO.TextureRotationYaw = TextureRotationYaw;
				}
				if(bUpdateTextureRotationAnchorX)
				{
					CO.TextureRotationAnchor.X = TextureRotationAnchorX;
				}
				if(bUpdateTextureRotationAnchorY)
				{
					CO.TextureRotationAnchor.Y = TextureRotationAnchorY;
				}
				if(bUpdateStretchHorizontally)
				{
					CO.bStretchHorizontally = bStretchHorizontally;
				}
				if(bUpdateStretchVertically)
				{
					CO.bStretchVertically = bStretchVertically;
				}
				if(bUpdateStretchScalingFactor)
				{
					CO.StretchScalingFactor = FClamp(StretchScalingFactor, 0.f , 1.f);
				}

				CO.UpdateDynamicProperties();
			}
		}
	}
}

defaultproperties
{
	ObjName="CO > Image > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Objects",PropertyName=CanvasObjectTag)

	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Image Type",PropertyName=ImageTypeIdx,MaxVars=1,bHidden=true)

	VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="Material",PropertyName=Material,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized U",PropertyName=UVCoordsNormalizedU,MaxVars=1,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized V",PropertyName=UVCoordsNormalizedV,MaxVars=1,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized UL",PropertyName=UVCoordsNormalizedUL,MaxVars=1,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized VL",PropertyName=UVCoordsNormalizedVL,MaxVars=1,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Float',LinkDesc="Material Rot Yaw",PropertyName=MaterialRotationYaw,MaxVars=1,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Float',LinkDesc="Material Rot Anchor X",PropertyName=MaterialRotationAnchorX,MaxVars=1,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Material Rot Anchor Y",PropertyName=MaterialRotationAnchorY,MaxVars=1,bHidden=true)

	VariableLinks(11)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Mode",PropertyName=TextureModeIdx,MaxVars=1,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Object',LinkDesc="Texture",PropertyName=Texture,MaxVars=1,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color R",PropertyName=TextureColorR,MaxVars=1,bHidden=true)
	VariableLinks(14)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color G",PropertyName=TextureColorG,MaxVars=1,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color B",PropertyName=TextureColorB,MaxVars=1,bHidden=true)
	VariableLinks(16)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color A",PropertyName=TextureColorA,MaxVars=1,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords U",PropertyName=UVCoordsU,MaxVars=1,bHidden=true)
	VariableLinks(18)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords V",PropertyName=UVCoordsV,MaxVars=1,bHidden=true)
	VariableLinks(19)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords UL",PropertyName=UVCoordsUL,MaxVars=1,bHidden=true)
	VariableLinks(20)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords VL",PropertyName=UVCoordsVL,MaxVars=1,bHidden=true)

	VariableLinks(21)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Blend Mode",PropertyName=TextureBlendModeIdx,MaxVars=1,bHidden=true)

	VariableLinks(22)=(ExpectedType=class'SeqVar_Float',LinkDesc="Texture Rot Yaw",PropertyName=TextureRotationYaw,MaxVars=1,bHidden=true)
	VariableLinks(23)=(ExpectedType=class'SeqVar_Float',LinkDesc="Texture Rot Anchor X",PropertyName=TextureRotationAnchorX,MaxVars=1,bHidden=true)
	VariableLinks(24)=(ExpectedType=class'SeqVar_Float',LinkDesc="Texture Rot Anchor Y",PropertyName=TextureRotationAnchorY,MaxVars=1,bHidden=true)

	VariableLinks(25)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Stretch Horizontally",PropertyName=bStretchHorizontally,MaxVars=1,bHidden=true)
	VariableLinks(26)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Stretch Vertically",PropertyName=bStretchVertically,MaxVars=1,bHidden=true)
	VariableLinks(27)=(ExpectedType=class'SeqVar_Float',LinkDesc="Stretch Scaling Factor",PropertyName=StretchScalingFactor,MaxVars=1,bHidden=true)

	ImageTypeIdx=-1
	TextureModeIdx=-1
	TextureBlendModeIdx=-1
}