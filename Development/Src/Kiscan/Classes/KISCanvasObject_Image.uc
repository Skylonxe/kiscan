/**
 * Kiscan GUI Framework
 * 
 * KISCanvasObject_Image
 * 
 * CO Image renders a texture or a material. 
 * Texture rendering contains three subcategories:
 * Normal, Rotated, Stretched
 * - Normal gives ability to select Blend Mode. See UDN for more info about Blend Mode).
 * - Rotated can rotate a texture.
 * - Stretched is mode which allows special upscaling of the texture. See UDN (Two/CanvasReference.html) for more info.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISCanvasObject_Image extends KISCanvasObject;

/** Marks a position of MaterialRotationAnchor or TextureRotationAnchor. */
var(Debug) bool bDrawRotationAnchor;

/** Rendering mode. */
var(Image) EKISImageType ImageType;

/** Material to render. */
var(Image_Material) MaterialInterface Material;
/** Normalized UVCoords of Material. 1.0 = full size. */
var(Image_Material) KISUVNormalized UVCoordsNormalized;
/** Current Material rotation in degrees. Has to be value between (including) 0 and 360. */
var(Image_Material) float MaterialRotationYaw<ClampMin=0.0|ClampMax=360.0>;
/** Anchor of the Material rotation. X=0.5,Y=0.5 is the middle of Material. */
var(Image_Material) Vector2D MaterialRotationAnchor;

/** Texture rendering mode. */
var(Image_Texture) EKISTextureMode TextureMode;
/** Texture to render. */
var(Image_Texture) Texture Texture;
/** Color and Alpha of Texture. White means normal. */
var(Image_Texture) Color TextureColor;
/** UVCoords of Texture. */
var(Image_Texture) KISUVAbsolute UVCoords;

/** Blend mode of Texture. */
var(Image_Texture_Normal) EBlendMode TextureBlendMode;

/** Current Texture rotation in degrees. Has to be value between (including) 0 and 360. */
var(Image_Texture_Rotated) float TextureRotationYaw<ClampMin=0.0|ClampMax=360.0>;
/** Anchor of the Texture rotation. X=0.5,Y=0.5 is the middle of Texture. */
var(Image_Texture_Rotated) Vector2D TextureRotationAnchor;

/** Enable Horizontal Stretching. */
var(Image_Texture_Stretched) bool bStretchHorizontally;
/** Enable Vertical Stretching. */
var(Image_Texture_Stretched) bool bStretchVertically;
/** Scaling factor, Value between (including) 0 and 1. */
var(Image_Texture_Stretched) float StretchScalingFactor<ClampMin=0.0|ClampMax=1.0>;

/**
 * RenderMasked
 * Override
 */
function RenderMasked(Canvas C, float DeltaTime)
{
	C.SetPos(OutputPosition.X, OutputPosition.Y);

	switch(ImageType)
	{
		case IT_Material:
			if(Material != none)
			{
				C.DrawRotatedMaterialTile(Material, MakeRotator(0, MaterialRotationYaw * DegToUnrRot, 0), OutputSize.X, OutputSize.Y, UVCoordsNormalized.U, UVCoordsNormalized.V, UVCoordsNormalized.UL, UVCoordsNormalized.VL, MaterialRotationAnchor.X, MaterialRotationAnchor.Y);
			}
			break;
		case IT_Texture:
			if(Texture != none)
			{
				C.SetDrawColorStruct(TextureColor);

				switch(TextureMode)
				{
					case TM_Normal:
						C.DrawTile(Texture, OutputSize.X, OutputSize.Y, UVCoords.U, UVCoords.V, UVCoords.UL, UVCoords.VL,,, TextureBlendMode);
						break;
					case TM_Rotated:
						C.DrawRotatedTile(Texture, MakeRotator(0, TextureRotationYaw * DegToUnrRot, 0), OutputSize.X, OutputSize.Y, UVCoords.U, UVCoords.V, UVCoords.UL, UVCoords.VL, TextureRotationAnchor.X, TextureRotationAnchor.Y);
						break;
					case TM_Stretched:
						C.DrawTileStretched(Texture, OutputSize.X, OutputSize.Y, UVCoords.U, UVCoords.V, UVCoords.UL, UVCoords.VL,, bStretchHorizontally, bStretchVertically, StretchScalingFactor);
						break;
					default:
						break;
				}
			}
			break;	
		default:
			break;
	}
}

/**
 * RenderDebug
 * Override
 */
function RenderDebug(Canvas C, float DeltaTime)
{
	super.RenderDebug(C, DeltaTime);
	
	if(bEnabled && bRender && CheckResolutionLimit())
	{
		if(bDrawRotationAnchor)
		{
			if(ImageType == IT_Material)
			{
				DrawDebugCross(C, OutputPosition.X + OutputSize.X * MaterialRotationAnchor.X, OutputPosition.Y + OutputSize.Y * MaterialRotationAnchor.Y, 15, DebugColor);
			}
			else
			{
				DrawDebugCross(C, OutputPosition.X + OutputSize.X * TextureRotationAnchor.X, OutputPosition.Y + OutputSize.Y * TextureRotationAnchor.Y, 15, DebugColor);
			}
		}
	}
}

defaultproperties
{
	ImageType=IT_Texture

	Material=`DefaultMaterial
	UVCoordsNormalized=(U=0.f,V=0.f,UL=1.f,VL=1.f)
	MaterialRotationAnchor=(X=0.5f,Y=0.5f)

	Texture=`DefaultTexture
	TextureColor=(R=255,G=255,B=255,A=255)
	UVCoords=(U=0,V=0,UL=128,VL=128)

	TextureRotationYaw=90.f
	TextureRotationAnchor=(X=0.5f,Y=0.5f)

	bStretchHorizontally=true
	bStretchVertically=true
	StretchScalingFactor=1.f
}