/**
 * Kiscan GUI Framework
 * 
 * KISCanvasObject_SimpleText
 * 
 * CO Simple Text renders one line text.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISCanvasObject_SimpleText extends KISCanvasObject;

/** Text to render. Programmers use UpdateText() to set it. */
var(Simple_Text) protectedwrite string Text<MultilineWithMaxRows=10>;
/** Font of the text. */
var(Simple_Text) Font Font;
/** Color of the text. */
var(Simple_Text) Color TextColor;
/** Enables a shadow under the text with supported Font. */
var(Simple_Text) bool bEnableShadow;

/** Text which is currently rendered. Usually same as Text variable. Text can contain illegal characters which are removed in UpdateText() and the final
 *  string is then stored in this variable. */
var string RenderedText;

/**
 * RenderMasked
 * Override
 */
function RenderMasked(Canvas C, float DeltaTime)
{
	local FontRenderInfo FRInfo;
	
	if(Font != none)
	{
		if(RenderedText != "")
		{
			C.SetPos(OutputPosition.X, OutputPosition.Y);
			C.SetDrawColorStruct(TextColor);
			C.Font = Font;
			FRInfo = C.CreateFontRenderInfo(true, bEnableShadow);
			C.DrawText(RenderedText, true, OutputSize.X, OutputSize.Y, FRInfo);
		}
	}
}

/**
 * UpdateDynamicProperties
 * Override
 * Singular because of UpdateText().
 */
singular function UpdateDynamicProperties()
{
	local float OutputTextWidth, OutputTextHeight;

	// Recalculate fixed property
	OutputPosition = GetAdjustedPosition(Position, GetDrawMode(), Handle);
	// Add Position of Component
	OutputPosition.X += ParentComponent.OutputPosition.X;
	OutputPosition.Y += ParentComponent.OutputPosition.Y;

	// Recalculate fixed property
	OutputSize = GetAdjustedSize(Size, GetDrawMode(), Handle);

	// When Init() calls this function first time, RenderedText is none
	// We update RenderedText because we need it in this function
	// UpdateText() calls again this function, that is why we need to use "singular"
	UpdateText(Text);

	// Get an output size of the text
	OutputTextWidth = GetWidthOfString(RenderedText);
	OutputTextHeight = GetMaxFontHeight();

	// Apply Anchor
	OutputPosition.X -= OutputTextWidth * Anchor.X;
	OutputPosition.Y -= OutputTextHeight * Anchor.Y;

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
	OutputMaskPosition.X += OutputTextWidth * MaskPositionInCO.X;
	OutputMaskPosition.Y += OutputTextHeight * MaskPositionInCO.Y;

	if(bAutoFitShape)
	{
		// Automatic Input Shape properties
		OutputShapePosition = OutputPosition;

		OutputShapeSize.X = OutputTextWidth;
		OutputShapeSize.Y = OutputTextHeight;
	}
	else
	{
		// Recalculate fixed property
		OutputShapeSize = GetAdjustedSize(ShapeSize, GetDrawMode(), Handle);
		// Recalculate fixed property
		OutputShapePosition = GetAdjustedPosition(ShapePositionOffset, GetDrawMode(), Handle);
		// Apply Shape Position In CO and Shape Anchor
		OutputShapePosition.X += OutputPosition.X + OutputTextWidth * ShapePositionInCO.X - OutputShapeSize.X * ShapeAnchor.X;
		OutputShapePosition.Y += OutputPosition.Y + OutputTextHeight * ShapePositionInCO.Y - OutputShapeSize.Y * ShapeAnchor.Y;
	}
}

/**
 * UpdateText
 * Declaration
 * Use to set the rendered text.
 * 
 * @param NewText
 */
function UpdateText(string NewText)
{
	Text = NewText;

	RenderedText = NewText;
	// Remove new line characters because they cause rendering on a second line and Simple Text should render the text only on the one like
	Repl(RenderedText, Chr(10), " ", false);
	Repl(RenderedText, Chr(13), " ", false);

	// Call this because the size of the text may changed
	UpdateDynamicProperties();
}

/**
 * GetCharPosition
 * Declaration
 * Returns X,Y position (pixels) of the Nth char in CheckString.
 * Useful when we want to get a position of a caret.
 * 
 * @param CheckString Usually RenderedText.
 * @param CharIdx Index of char which position we want.
 * 
 * @return 2D position of the requested char.
 */
function IntPoint GetCharPosition(string CheckString, int CharIdx)
{
	local string CurrentTextToCharIdx;
	local IntPoint Result;
	local int XL, YL;

	if(Len(CheckString) > 0 && Font != none)
	{
		CurrentTextToCharIdx = Left(CheckString, CharIdx);
		Font.GetStringHeightAndWidth(CurrentTextToCharIdx, YL, XL);

		Result.X = XL * OutputSize.X * Font.GetScalingFactor(HUD.SizeY);
		Result.Y = 0;
	}
	
	Result.X += OutputPosition.X;
	Result.Y += OutputPosition.Y;

	return Result;
}

/**
 * GetWidthOfString
 * Declaration
 * Returns the current size of a string in pixels.
 * 
 * @param S
 * 
 * @return Width of S string.
 */
function float GetWidthOfString(string S)
{
	local int XL, YL;
	local float XLF;

	if(Font != none)
	{
		Font.GetStringHeightAndWidth(S, YL, XL);
		XLF = XL * OutputSize.X * Font.GetScalingFactor(HUD.SizeY);
	}

	return XLF;
}

/**
 * GetMaxFontHeight
 * Declaration
 * 
 * @return Current maximal vertical size of Font.
 */
function float GetMaxFontHeight()
{
	local float Result;

	if(Font != none)
	{
		Result = Font.GetMaxCharHeight() * OutputSize.Y * Font.GetScalingFactor(HUD.SizeY);
	}

	return Result;
}

/**
 * ClampTextByWidth
 * Declaration
 * Clamps a string by width.
 * 
 * @param T String to clamp.
 * @param MaxWidth Maximal width of a string in pixels.
 * 
 * @return Clamped string.
 */
function string ClampTextByWidth(string T, float MaxWidth)
{
	local string Result;
	local float CurrentSize;
	local int NumberOfChars;

	NumberOfChars = 0;

	while(CurrentSize <= MaxWidth && NumberOfChars <= Len(T))
	{
		Result = Left(T, NumberOfChars);
		CurrentSize = GetWidthOfString(Result);

		if(CurrentSize > MaxWidth)
		{
			Result = Left(T, NumberOfChars - 1);
			break;
		}
		NumberOfChars++;
	}

	return Result;
}

defaultproperties
{
	Size=(X=1.f,Y=1.f)

	Text=`DefaultText
	Font=`DefaultFont
	TextColor=(R=255,G=255,B=255,A=255)
}
