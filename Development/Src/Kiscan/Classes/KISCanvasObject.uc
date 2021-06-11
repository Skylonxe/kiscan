/**
 * Kiscan GUI Framework
 * 
 * KISCanvasObject
 * 
 * Canvas Object (CO) is the class which represents only a visual part of Component. It can render shapes, images, texts
 * but It should not do anything dynamic e.g. accept the input, change the looks by itself, etc.
 * It is attached to Component, so they move together.
 * Every CO can use Input Shape. Input Shape is a special invisible shape (however debug bool bDrawShape can enable rendering of the shape)
 * which is used to determine bounds of CO.
 * We primary use it when determining what is under the cursor.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISCanvasObject extends KISObject
	abstract
	editinlinenew;

/** Transparency of Input Shape when bDrawShape and bTransparentShape is true. Transparency = ShapeColor.A * TransparentShapeAlpha. */
const TransparentShapeAlpha = 0.5f;

/** Dynamic property. Position of CO. Position adds to Position of Component. */
var(Basic_Appearance) KISGUIPosition Position;
/** Dynamic property. Size of CO. Size can't be lower than 0.*/
var(Basic_Appearance) KISVector2DUnsigned Size;
/** Anchor defines if Position represents the point in the middle of CO or elsewhere. X=0,Y=0 -> top left corner, X=1,Y=1 -> bottom right corner. Anchor has to be between (including) 0 and 1. 
 *  Result is calculated by simple math: OutputPosition = OutputPosition - (Size * Anchor). */
var(Basic_Appearance) KISVector2DNorm Anchor;

/** Debug property. Displays the visual debugging graph of Position. */ 
var(Debug) bool bDrawPosition;
/** Debug property. Marks current OutputPosition and displays its value. */
var(Debug) bool bDrawOutputPosition;
/** Debug property. Draws Input Shape. Input Shape is less visible (TransparentShapeAlpha const) when bTransparentShape is true. */
var(Debug) bool bDrawShape;
/** Debug property. Color of Input Shape. bDrawShape has to be true to see the effect. */
var(Debug) Color ShapeColor<EditCondition=bDrawShape>;
/** Debug property. Draws Mask. */
var(Debug) bool bDrawMask;
/** Debug property. Color of Mask. bDrawMask has to be true to see the effect. */
var(Debug) Color MaskColor<EditCondition=bDrawMask>;
/** Debug property. Displays current Priority of CO. */
var(Debug) bool bDrawPriority;
/** Debug property. Displays current Tag of CO. */
var(Debug) bool bDrawTag;
/** Debug property. Color of the debug drawing. */
var(Debug) Color DebugColor;
/** Debug property. Stops rendering of CO. This does not turn off Input Shape and other important properties. Use for the debugging only. */
var(Debug) bool bDisableRendering;

/** If true, Input Shape is enabled and Component can receive Mouse Input and Mouse Hover events. */ 
var(Input_Shape) bool bShapeEnabled;
/** Possible shapes of Input Shape. bShapeEnabled has to be true to edit this variable. */
var(Input_Shape) EKISComponentShape Shape<EditCondition=bShapeEnabled>;
/** Transparent Input Shape allows the framework to cache also other Components that are under this one.
 *  For example, when you will place two buttons on the same place, both will be set to Hover State when you will
 *  place the mouse cursor on them. With bTransparentShape set to false, only first button will be set to Hover State. 
 *  bShapeEnabled has to be true to edit this variable. */
var(Input_Shape) bool bTransparentShape<EditCondition=bShapeEnabled>;
/** Automatically determine properties of Input Shape. This can save you a lot of time because you will not need to update
 *  Input Shape when you change Size or Position or some other property. Automatic Input Shape usually covers whole CO.
 *  bShapeEnabled has to be true to edit this variable. */
var(Input_Shape) bool bAutoFitShape<EditCondition=bShapeEnabled>;
/** Position where Input Shape will be placed in CO. X=0,Y=0 -> top left corner of CO, X=1,Y=1 -> bottom right corner of CO.
 *  bAutoFitShape has to be false to edit this variable. */
var(Input_Shape) Vector2D ShapePositionInCO<DisplayName="Shape Position In CO"|EditCondition=!bAutoFitShape>;
/** Dynamic property. Offset from the current position of Input Shape. bAutoFitShape has to be false to edit this variable. */
var(Input_Shape) KISGUIPosition ShapePositionOffset<EditCondition=!bAutoFitShape>;
/** Dynamic property. Size of Input Shape. Can't be lower than 0. bAutoFitShape has to be false to edit this variable. */
var(Input_Shape) KISVector2DUnsigned ShapeSize<EditCondition=!bAutoFitShape>;
/** Anchor of Input Shape. It defines if Shape Position represents the point in the middle of Input Shape or elsewhere.
 *  Anchor has to be between (including) 0 and 1. Result is calculated by simple math: OutputShapePosition = OutputShapePosition - (ShapeSize * ShapeAnchor).
 *  bAutoFitShape has to be false to edit this variable. */
var(Input_Shape) KISVector2DNorm ShapeAnchor<EditCondition=!bAutoFitShape>;

/** Mask can define a region in which you will be able to render CO. Parts that are not in this region will not be rendered.
 *  Simply, It creates an invisible window which cuts CO. */
var(Mask) bool bUseMask;
/** Mask is usually attached to CO, so they move together. This variable gives you an ability to detach it from CO and attach it directly
 *  to Component. Mask will not be affected by Position of CO if this is false. bUseMask has to be true to edit this variable. */
var(Mask) bool bAttachMask<EditCondition=bUseMask>;
/** Position where Mask will be placed in CO. X=0,Y=0 -> top left corner of CO, X=1,Y=1 -> bottom right corner of CO.
 *  bUseMask has to be true to edit this variable. */
var(Mask) Vector2D MaskPositionInCO<DisplayName="Mask Position In CO"|EditCondition=bUseMask>;
/** Dynamic property. Offset from the current position of Mask. bUseMask has to be true to edit this variable. */
var(Mask) KISGUIPosition MaskPositionOffset<EditCondition=bUseMask>;
/** Dynamic property. Size of Mask. Can't be lower than 0. bUseMask has to be true to edit this variable. */
var(Mask) KISVector2DUnsigned MaskSize<EditCondition=bUseMask>;
/** Anchor of Mask. It defines if the position of Mask represents the point in the middle of Mask or elsewhere.
 *  Anchor has to be between (including) 0 and 1. Result is calculated by simple math: OutputMaskPosition = OutputMaskPosition - (MaskSize * MaskAnchor).
 *  bUseMask has to be true to edit this variable. */
var(Mask) KISVector2DNorm MaskAnchor<EditCondition=bUseMask>;

/** Set false if you want to disable (hide) this CO. CO will not be processed anymore. This property disables also Input Shape. */
var(Rendering) bool bEnabled;
/** Useful when you have multiple Canvas Objects in one list. Priority determines order of rendering of Canvas Objects. Programmers can use
 *  SetPriority() to update it. */
var(Rendering) privatewrite int Priority;
/** Resolution Limit allows you to enable rendering of this CO only at certain resolutions. Useful when you want to have e.g. multiple images with different Size
 *  and Texture and render only one which is assigned to the current resolution. */
var(Rendering) bool bUseResolutionLimit;
/** Minimal vertical size of the resolution at which will be this CO rendered. bUseResolutionLimit has to be true to edit this variable. Can't be lower than 1. */
var(Rendering) int ResolutionLimitMinY<EditCondition=bUseResolutionLimit|ClampMin=1>;
/** Maximal vertical size of the resolution at which will be this CO rendered. bUseResolutionLimit has to be true to edit this variable. Can't be lower than 1. */
var(Rendering) int ResolutionLimitMaxY<EditCondition=bUseResolutionLimit|ClampMin=1>;

/** Tag/Name of CO. We use Tag when we want to reference certain CO in Kismet. There can not be two COs with same Tag in one Component. */
var name Tag;
/** Same as bEnabled, however this can be controlled only by code. */
var bool bRender;

/** Output property. Final Position of CO in pixels. */
var IntPoint OutputPosition;
/** Output property. Final Size of CO in pixels. */
var Vector2D OutputSize;
/** Output property. Final ShapePosition of CO in pixels. */
var IntPoint OutputShapePosition;
/** Output property. Final ShapeSize of CO in pixels. */
var Vector2D OutputShapeSize;
/** Output property. Final MaskPosition of CO in pixels. */
var IntPoint OutputMaskPosition;
/** Output property. Final MaskSize of CO in pixels. */
var Vector2D OutputMaskSize;

/** Reference to HUD. */
var KISHUD HUD;
/** Reference to Handle. */
var KISHandle Handle;
/** Reference to Module. */
var KISModule Module;
/** Reference to parent Scene of Component. */
var KISScene ParentScene;
/** Reference to parent Component of COList or COSpecial. */
var KISComponent ParentComponent;
/** Reference to parent COList. COList can be the owner of CO. */
var KISCanvasObjectList ParentCOList;
/** Reference to parent COSpecial. COSpecial can be the owner of CO. */
var KISCanvasObjectSpecial ParentCOSpecial;

/**
 * Init
 * Declaration
 * Initialization happens when an object is newly created. We usually use PostBeginPlay() in Actors, however Object classes don't provide a function
 * like that, so we need to create custom one. We call Init() immediately after the creation of a new object.
 * We pass the chain of references as paramaters.
 * 
 * @param NewHUD
 * @param NewHandle
 * @param NewModule
 * @param NewParentScene
 * @param NewParentComponent
 * @param NewParentCOList CO can be created in COSpecial or in COList. If we created it in COSpecial, then this parameter is none.
 * @param NewParentCOSpecial CO can be created in COSpecial or in COList. If we created it in COList, then this parameter is none.
 */
function Init(KISHUD NewHUD, KISHandle NewHandle, KISModule NewModule, KISScene NewParentScene, KISComponent NewParentComponent, KISCanvasObjectList NewParentCOList, KISCanvasObjectSpecial NewParentCOSpecial)
{
	HUD = NewHUD;
	Handle = NewHandle;
	Module = NewModule;
	ParentScene = NewParentScene;
	ParentComponent = NewParentComponent;
	ParentCOList = NewParentCOList;
	ParentCOSpecial = NewParentCOSpecial;

	// We can calculate Output properties because we have all needed references
	UpdateDynamicProperties();
}

/**
 * Update
 * Declaration
 * Called always before the rendering. We can do there calculations that have to happen before the rendering process.
 * It is also cleaner because we do not mix calcuations with rendering.
 * Called every frame.
 * 
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function Update(float DeltaTime);

/**
 * Render
 * Declaration
 * Main function used for rendering of the GUI.
 * Canvas is accessible there.
 * Called every frame.
 * 
 * @param C Current Canvas.
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function Render(Canvas C, float DeltaTime)
{
	if(bEnabled && bRender && !bDisableRendering && CheckResolutionLimit())
	{
		// Apply Mask if needed
		if(bUseMask)
		{
			ApplyCanvasMask(C);
		}

		RenderMasked(C, DeltaTime);

		// Disable Mask if needed, 
		if(bUseMask)
		{
			RemoveCanvasMask(C);
			// We have to always disable Mask because otherwise it can apply on other objects too
		}
	}
}

/**
 * RenderMasked
 * Declaration
 * Same function as Render(), however this one can be already affected by Mask.
 * It is easier to declare another function for this because we will not need to apply Mask
 * everytime we override Render().
 * Called every frame.
 * 
 * @param C Current Canvas.
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function RenderMasked(Canvas C, float DeltaTime);

/**
 * RenderDebug
 * Declaration
 * Rendering function used for rendering of the debug.
 * This is always called after Render().
 * Called every frame.
 * 
 * @param C Current Canvas.
 * @param DeltaTime Current Delta Time. For more about Delta Time see Epic Forum.
 */
function RenderDebug(Canvas C, float DeltaTime)
{
	local Color ColorOfShape;
	local Texture2D CircleTexture;
	local string DebugString;

	if(bEnabled && bRender && CheckResolutionLimit())
	{
		if(bUseMask)
		{
			ApplyCanvasMask(C);
		}

		if(bDrawShape)
		{
			ColorOfShape = ShapeColor;

			if(bTransparentShape)
			{
				ColorOfShape.A *= TransparentShapeAlpha;
			}

			C.SetPos(OutputShapePosition.X, OutputShapePosition.Y);
			C.SetDrawColorStruct(ColorOfShape);
			
			if(Shape == CS_Box)
			{
				C.DrawRect(OutputShapeSize.X, OutputShapeSize.Y);
			}
			else if(Shape == CS_CircleOrEllipse)
			{
				CircleTexture = `CircleTexture;

				if(CircleTexture != none)
				{
					C.DrawTile(CircleTexture, OutputShapeSize.X, OutputShapeSize.Y, 0, 0, CircleTexture.SizeX, CircleTexture.SizeY);
				}
			}

			if(!bShapeEnabled)
			{
				DebugString @= "Shape disabled!";
			}
		}

		if(bDrawMask)
		{
			C.SetPos(OutputMaskPosition.X, OutputMaskPosition.Y);
			C.SetDrawColorStruct(MaskColor);
			C.DrawRect(OutputMaskSize.X, OutputMaskSize.Y);

			if(!bUseMask)
			{
				DebugString @= "Mask disabled!";
			}
		}

		if(bUseMask)
		{
			RemoveCanvasMask(C);
		}

		if(bDrawPosition)
		{
			DrawDebugPosition(C, ParentComponent.OutputPosition, Position, GetDrawMode(), Handle);
		}

		if(bDrawOutputPosition)
		{
			DrawDebugCross(C, OutputPosition.X, OutputPosition.Y, 15, DebugColor);
			DebugString @= "OutPosX:"@OutputPosition.X$", OutPosY:"@OutputPosition.Y;
		}

		if(bDrawPriority)
		{
			DebugString @= "Pri:"@Priority;
		}

		if(bDrawTag)
		{
			DebugString @= "Tag:"@string(Tag);
		}

		DrawDebugText(C, OutputPosition.X, OutputPosition.Y, DebugString, DebugColor);
	}
}

/**
 * UpdateDynamicProperties
 * Declaration
 * Recalculates output properties from fixed properties.
 * This is also called when the resolution gets changed because output properties depend on the size and the ratio
 * of the screen. We need to call this everytime we change some variable because many variables depend on each other.
 * Call this everytime you change any property!
 */
function UpdateDynamicProperties()
{
	// Recalculate fixed property
	OutputPosition = GetAdjustedPosition(Position, GetDrawMode(), Handle);
	// Add Position of Component
	OutputPosition.X += ParentComponent.OutputPosition.X;
	OutputPosition.Y += ParentComponent.OutputPosition.Y;

	// Recalculate fixed property
	OutputSize = GetAdjustedSize(Size, GetDrawMode(), Handle);

	// Apply Anchor
	OutputPosition.X -= OutputSize.X * Anchor.X;
	OutputPosition.Y -= OutputSize.Y * Anchor.Y;

	// Recalculate fixed property
	OutputMaskPosition = GetAdjustedPosition(MaskPositionOffset, GetDrawMode(), Handle);
	if(bAttachMask)
	{
		// Add Position of CO (which already contains Position of Component)
		OutputMaskPosition.X += OutputPosition.X;
		OutputMaskPosition.Y += OutputPosition.Y;
	}
	else
	{
		// Add Position of Component
		OutputMaskPosition.X += ParentComponent.OutputPosition.X;
		OutputMaskPosition.Y += ParentComponent.OutputPosition.Y;
	}

	// Recalculate fixed property
	OutputMaskSize = GetAdjustedSize(MaskSize, GetDrawMode(), Handle);

	// Apply Mask Anchor
	OutputMaskPosition.X -= OutputMaskSize.X * MaskAnchor.X;
	OutputMaskPosition.Y -= OutputMaskSize.Y * MaskAnchor.Y;
	// Apply Mask Position In CO
	OutputMaskPosition.X += OutputSize.X * MaskPositionInCO.X;
	OutputMaskPosition.Y += OutputSize.Y * MaskPositionInCO.Y;

	if(bAutoFitShape)
	{
		// Automatic Input Shape properties
		OutputShapePosition = OutputPosition;
		OutputShapeSize = OutputSize;
	}
	else
	{
		// Recalculate fixed property
		OutputShapeSize = GetAdjustedSize(ShapeSize, GetDrawMode(), Handle);
		// Recalculate fixed property
		OutputShapePosition = GetAdjustedPosition(ShapePositionOffset, GetDrawMode(), Handle);
		// Apply Shape Position In CO and Shape Anchor
		OutputShapePosition.X += OutputPosition.X + OutputSize.X * ShapePositionInCO.X - OutputShapeSize.X * ShapeAnchor.X;
		OutputShapePosition.Y += OutputPosition.Y + OutputSize.Y * ShapePositionInCO.Y - OutputShapeSize.Y * ShapeAnchor.Y;
	}
}

/**
 * IsOnShape
 * Declaration
 * Checks if CheckPosition is located on Input Shape.
 * Framework usually use it when determining what is under the cursor.
 * 
 * @param CheckPosition 2D Coords.
 * @param Out_bOnTransparentShape True if this CO has transparent Input Shape.
 * 
 * @return True if CheckPosition is located on this CO.
 */
function bool IsOnShape(IntPoint CheckPosition, out byte Out_bOnTransparentShape)
{
	local bool bResult;
	local Vector2D Center;
	local Vector2D PointNormalized;
	local Vector2D Radius;

	if(bEnabled && bRender && CheckResolutionLimit())
	{
		if(bShapeEnabled)
		{
			switch(Shape)
			{
				case CS_Box:
					if(CheckPosition.X >= OutputShapePosition.X && CheckPosition.Y >= OutputShapePosition.Y)
					{
						if(CheckPosition.X <= OutputShapePosition.X + OutputShapeSize.X && CheckPosition.Y <= OutputShapePosition.Y + OutputShapeSize.Y)
						{
							if(bUseMask)
							{
								// Apply Mask on Input Shape
								if(CheckPosition.X <= OutputMaskPosition.X + OutputMaskSize.X && CheckPosition.Y <= OutputMaskPosition.Y + OutputMaskSize.Y)
								{
									bResult = true;
								}
							}
							else
							{
								bResult = true;
							}
						}
					}
					break;
				case CS_CircleOrEllipse:
					if(OutputShapeSize.X != 0 && OutputShapeSize.Y != 0)
					{
						Center.X = OutputShapePosition.X + OutputShapeSize.X / 2.f;
						Center.Y = OutputShapePosition.Y + OutputShapeSize.Y / 2.f;

						Radius.X = OutputShapeSize.X / 2.f;
						Radius.Y = OutputShapeSize.Y / 2.f;

						PointNormalized.X = CheckPosition.X - Center.X;
						PointNormalized.Y = CheckPosition.Y - Center.Y;

						if(bUseMask)
						{
							// Apply Mask On Input Shape
							if(CheckPosition.X <= OutputMaskPosition.X + OutputMaskSize.X && CheckPosition.Y <= OutputMaskPosition.Y + OutputMaskSize.Y)
							{
								bResult = (PointNormalized.X * PointNormalized.X) / (Radius.X * Radius.X) + (PointNormalized.Y * PointNormalized.Y) / (Radius.Y * Radius.Y) <= 1.f;
							}
						}
						else
						{
							bResult = (PointNormalized.X * PointNormalized.X) / (Radius.X * Radius.X) + (PointNormalized.Y * PointNormalized.Y) / (Radius.Y * Radius.Y) <= 1.f;
						}
					}
					break;
				default:
					break;
			}

			Out_bOnTransparentShape = byte(bTransparentShape);
		}
	}
	
	return bResult;
}

/**
 * ApplyCanvasMask
 * Declaration
 * Applies Mask. Everything rendered after this function will be masked, so do not forget
 * to call RemoveCanvasMask() too.
 * 
 * @param C Current Canvas.
 */
function ApplyCanvasMask(Canvas C)
{
	local IntPoint ClampedMaskPosition;
	local IntPoint ClampedMaskSize;

	// Fix UDK bug
	// Mask does not work when OutputMaskPosition is negative
	ClampedMaskPosition.X = FMax(OutputMaskPosition.X, 0.f);
	ClampedMaskPosition.Y = FMax(OutputMaskPosition.Y, 0.f);
				
	if(ClampedMaskPosition.X == 0.f)
	{
		ClampedMaskSize.X = OutputMaskSize.X + OutputMaskPosition.X;
	}
	else
	{
		ClampedMaskSize.X = OutputMaskSize.X;
	}
	if(ClampedMaskPosition.Y == 0.f)
	{
		ClampedMaskSize.Y = OutputMaskSize.Y + OutputMaskPosition.Y;
	}
	else
	{
		ClampedMaskSize.Y = OutputMaskSize.Y;
	}

	ClampedMaskSize.X = FMax(ClampedMaskSize.X, 0.f);
	ClampedMaskSize.Y = FMax(ClampedMaskSize.Y, 0.f);
	// End of fix

	// Apply Mask
	C.PushMaskRegion(ClampedMaskPosition.X, ClampedMaskPosition.Y, ClampedMaskSize.X, ClampedMaskSize.Y);
}

/**
 * RemoveCanvasMask
 * Declaration
 * Removes Mask. Everything rendered after this function will not be masked.
 * 
 * @param C Current Canvas.
 */
function RemoveCanvasMask(Canvas C)
{
	C.PopMaskRegion();
}

/**
 * SetPriority
 * Declaration
 * Updates Priority of CO.
 * We use this setter function because we always need to update order of COs in current COList too.
 * 
 * @param NewPriority
 */
function SetPriority(int NewPriority)
{
	Priority = NewPriority;
	
	if(ParentCOList != none)
	{
		ParentCOList.CanvasObject.Sort(ParentCOList.CanvasObjectPrioritySort);
	}
}

/**
 * CheckResolutionLimit
 * Declaration
 * 
 * @return True if Resolution Limit is OK and we can e.g. draw this CO.
 */
function bool CheckResolutionLimit()
{
	return !bUseResolutionLimit || IsInRange(HUD.SizeY, Abs(ResolutionLimitMinY), Abs(ResolutionLimitMaxY));
}

/**
 * GetDrawMode
 * Declaration
 * Draw Mode has to use the getter because it can be overrode by Scene's ParentScene and we don't know
 * how long that SubScene chain is.
 * 
 * @return Current Draw Mode.
 */
function EKISDrawMode GetDrawMode()
{
	return ParentComponent.GetDrawMode();
}

/**
 * Destroy
 * Declaration
 * Destroys this object and all possible references to it, so Garbage Collector
 * will be able to process it.
 */
function Destroy()
{
	if(ParentCOList != none)
	{
		ParentCOList.CanvasObject.RemoveItem(self);
	}

	if(ParentCOSpecial != none)
	{
		ParentCOSpecial.CanvasObject = none;
	}

	HUD = none;
	Handle = none;
	Module = none;
	ParentScene = none;
	ParentComponent = none;
	ParentCOList = none;
}

defaultproperties
{
	Size=(X=128.f,Y=128.f)

	ShapeColor=(R=0,G=255,B=255,A=255)
	MaskColor=(R=255,G=255,B=0,A=255)
	DebugColor=(R=128,G=255,B=0,A=255)

	bAutoFitShape=true
	ShapeSize=(X=128.f,Y=128.f)

	bAttachMask=true
	MaskSize=(X=64.f,Y=64.f)

	bEnabled=true
	ResolutionLimitMinY=900
	ResolutionLimitMaxY=1080

	bRender=true
}