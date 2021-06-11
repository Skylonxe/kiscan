/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_Image_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) string CanvasObjectTag;

var(Image) editconst EKISImageType ImageType;
var int ImageTypeIdx;

var(Image_Material) editconst Object Material;
var(Image_Material) editconst float UVCoordsNormalizedU;
var(Image_Material) editconst float UVCoordsNormalizedV;
var(Image_Material) editconst float UVCoordsNormalizedUL;
var(Image_Material) editconst float UVCoordsNormalizedVL;
var(Image_Material) editconst float MaterialRotationYaw;
var(Image_Material) editconst float MaterialRotationAnchorX;
var(Image_Material) editconst float MaterialRotationAnchorY;

var(Image_Texture) editconst EKISTextureMode TextureMode;
var int TextureModeIdx;
var(Image_Texture) editconst Object Texture;
var(Image_Texture) editconst int TextureColorR;
var(Image_Texture) editconst int TextureColorG;
var(Image_Texture) editconst int TextureColorB;
var(Image_Texture) editconst int TextureColorA;
var(Image_Texture) editconst int UVCoordsU;
var(Image_Texture) editconst int UVCoordsV;
var(Image_Texture) editconst int UVCoordsUL;
var(Image_Texture) editconst int UVCoordsVL;

var(Image_Texture_Normal) editconst EBlendMode TextureBlendMode;
var int TextureBlendModeIdx;

var(Image_Texture_Rotated) editconst float TextureRotationYaw;
var(Image_Texture_Rotated) editconst float TextureRotationAnchorX;
var(Image_Texture_Rotated) editconst float TextureRotationAnchorY;

var(Image_Texture_Stretched) editconst bool bStretchHorizontally;
var(Image_Texture_Stretched) editconst bool bStretchVertically;
var(Image_Texture_Stretched) editconst float StretchScalingFactor;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}


function UpdateProperties(KISComponent Comp)
{
	local KISCanvasObject_Image CO;
	local KISCanvasObject COObj;

	if(Comp != none)
	{
		COObj = Comp.GetCOByTag(name(CanvasObjectTag));

		if(COObj != none)
		{
			CO = KISCanvasObject_Image(COObj);
		}

		if(CO != none)
		{
			ImageTypeIdx = CO.ImageType;
			ImageType = EKISImageType(ImageTypeIdx);

			Material = CO.Material;
			UVCoordsNormalizedU = CO.UVCoordsNormalized.U;
			UVCoordsNormalizedV = CO.UVCoordsNormalized.V;
			UVCoordsNormalizedUL = CO.UVCoordsNormalized.UL;
			UVCoordsNormalizedVL = CO.UVCoordsNormalized.VL;
			MaterialRotationYaw = CO.MaterialRotationYaw;
			MaterialRotationAnchorX = CO.MaterialRotationAnchor.X;
			MaterialRotationAnchorY = CO.MaterialRotationAnchor.Y;

			TextureModeIdx = CO.TextureMode;
			TextureMode = EKISTextureMode(TextureModeIdx);
			Texture = CO.Texture;
			TextureColorR = CO.TextureColor.R;
			TextureColorG = CO.TextureColor.G;
			TextureColorB = CO.TextureColor.B;
			TextureColorA = CO.TextureColor.A;
			UVCoordsU = CO.UVCoords.U;
			UVCoordsV = CO.UVCoords.V;
			UVCoordsUL = CO.UVCoords.UL;
			UVCoordsVL = CO.UVCoords.VL;

			TextureBlendModeIdx = CO.TextureBlendMode;
			TextureBlendMode = EBlendMode(TextureBlendModeIdx);

			TextureRotationYaw = CO.TextureRotationYaw;
			TextureRotationAnchorX = CO.TextureRotationAnchor.X;
			TextureRotationAnchorY = CO.TextureRotationAnchor.Y;

			bStretchHorizontally = CO.bStretchHorizontally;
			bStretchVertically = CO.bStretchVertically;
			StretchScalingFactor = CO.StretchScalingFactor;
		}
	}
}

defaultproperties
{
	ObjName="CO > Image > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Object",PropertyName=CanvasObjectTag,MaxVars=1)

	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Image Type",PropertyName=ImageTypeIdx,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(3)=(ExpectedType=class'SeqVar_Object',LinkDesc="Material",PropertyName=Material,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized U",PropertyName=UVCoordsNormalizedU,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized V",PropertyName=UVCoordsNormalizedV,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized UL",PropertyName=UVCoordsNormalizedUL,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Float',LinkDesc="UVCoords Normalized VL",PropertyName=UVCoordsNormalizedVL,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Float',LinkDesc="Material Rot Yaw",PropertyName=MaterialRotationYaw,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Float',LinkDesc="Material Rot Anchor X",PropertyName=MaterialRotationAnchorX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Material Rot Anchor Y",PropertyName=MaterialRotationAnchorY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(11)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Mode",PropertyName=TextureModeIdx,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Object',LinkDesc="Texture",PropertyName=Texture,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color R",PropertyName=TextureColorR,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(14)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color G",PropertyName=TextureColorG,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color B",PropertyName=TextureColorB,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(16)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Color A",PropertyName=TextureColorA,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords U",PropertyName=UVCoordsU,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(18)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords V",PropertyName=UVCoordsV,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(19)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords UL",PropertyName=UVCoordsUL,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(20)=(ExpectedType=class'SeqVar_Int',LinkDesc="UVCoords VL",PropertyName=UVCoordsVL,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(21)=(ExpectedType=class'SeqVar_Int',LinkDesc="Texture Blend Mode",PropertyName=TextureBlendModeIdx,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(22)=(ExpectedType=class'SeqVar_Float',LinkDesc="Texture Rot Yaw",PropertyName=TextureRotationYaw,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(23)=(ExpectedType=class'SeqVar_Float',LinkDesc="Texture Rot Anchor X",PropertyName=TextureRotationAnchorX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(24)=(ExpectedType=class'SeqVar_Float',LinkDesc="Texture Rot Anchor Y",PropertyName=TextureRotationAnchorY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(25)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Stretch Horizontally",PropertyName=bStretchHorizontally,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(26)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Stretch Vertically",PropertyName=bStretchVertically,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(27)=(ExpectedType=class'SeqVar_Float',LinkDesc="Stretch Scaling Factor",PropertyName=StretchScalingFactor,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}