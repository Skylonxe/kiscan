/**
 * Kiscan GUI Framework
 * 
 * KISCanvasObject_ScriptedText
 * 
 * CO Scripted Text renders multiline text.
 * It supports automatical line breaking on the end of line and manual line breaking by using
 * special NewLineCharacter.
 * It also supports Alignment - Left, Center, Right.
 * 
 * Originally, this was subclass of Simple Text, however it caused more problems than benefits.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISCanvasObject_ScriptedText extends KISCanvasObject;

/** New line character. */
`define NewLineChar GetNewLineChar()

/** Displays the end of line. bEnableLineBreaking has to be true. */
var(Debug) bool bDrawEndOfLine;

/** Text to render. Programmers use UpdateText() to set it. */
var(Scripted_Text) protectedwrite string Text<MultilineWithMaxRows=10>;
/** Font of the text. */
var(Scripted_Text) Font Font;
/** Color of the text. */
var(Scripted_Text) Color TextColor;
/** Enables a shadow under the text with supported Font. */
var(Scripted_Text) bool bEnableShadow;

/** Automatic line breaking on the end of line. */
var(Scripted_Text) bool bEnableLineBreaking;
/** Dynamic property. Length of line. bEnableLineBreaking has to be true to edit this variable. Can not be lower than 1.*/
var(Scripted_Text) int LineLength<EditCondition=bEnableLineBreaking|ClampMin=1>;
/** Character used for a manual line breaking. Only first character of this string is used! */
var(Scripted_Text) string NewLineCharacter<DisplayName="New Line Character (1)">;
/** Alignment of the text. Same as in any other text editor. */
var(Scripted_Text) EKISTextAlign Alignment;

/** Output property. Final LineLength in pixels. */
var int OutputLengthOfLine;
/** Length of the longest line in pixels. */
var float LongestLineWidth;
/** Height of the whole text window in pixels. */
var float WrappedTextHeight;

/** Text divided into individual lines. */
var array<string> WrappedText;
/** Same as WrappedText, however it does not contain new line characters. This array is iterated when rendering the text. */
var array<string> WrappedTextWithoutNewLine;

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
	local float CurrentLineWidth;
	local string FoundString;
	
	if(Font != none && Len(`NewLineChar) > 0)
	{
		if(RenderedText != "")
		{
			C.SetPos(OutputPosition.X, OutputPosition.Y);
			C.SetDrawColorStruct(TextColor);
			C.Font = Font;
			FRInfo = C.CreateFontRenderInfo(true, bEnableShadow);

			switch(Alignment)
			{
				case TA_Left:
					foreach WrappedTextWithoutNewLine(FoundString)
					{
						C.DrawText(FoundString, true, OutputSize.X, OutputSize.Y, FRInfo);
						C.SetPos(OutputPosition.X, C.CurY + GetMaxFontHeight());
					}
					break;
				case TA_Center:
					foreach WrappedTextWithoutNewLine(FoundString)
					{
						CurrentLineWidth = GetWidthOfString(FoundString);

						C.SetPos(OutputPosition.X + (LongestLineWidth - CurrentLineWidth) / 2.f, C.CurY);
						C.DrawText(FoundString, true, OutputSize.X, OutputSize.Y, FRInfo);
						C.SetPos(OutputPosition.X, C.CurY + GetMaxFontHeight());
					}
					break;
				case TA_Right:
					foreach WrappedTextWithoutNewLine(FoundString)
					{ 
						CurrentLineWidth = GetWidthOfString(FoundString);

						C.SetPos(OutputPosition.X + LongestLineWidth - CurrentLineWidth, C.CurY);
						C.DrawText(FoundString, true, OutputSize.X, OutputSize.Y, FRInfo);
						C.SetPos(OutputPosition.X, C.CurY + GetMaxFontHeight());
					}
					break;
				default:
					break;
			}
		}
	}
}

/**
 * RenderDebug
 * Override
 */
function RenderDebug(Canvas C, float DeltaTime)
{
	local string DebugString;

	super.RenderDebug(C, DeltaTime);

	if(bEnabled && bRender && CheckResolutionLimit())
	{
		if(bUseMask)
		{
			ApplyCanvasMask(C);
		}

		if(bDrawEndOfLine && bEnableLineBreaking)
		{
			C.Draw2DLine(OutputPosition.X + OutputLengthOfLine, OutputPosition.Y, OutputPosition.X + OutputLengthOfLine, OutputPosition.Y + WrappedTextHeight, DebugColor);
		}

		if(bUseMask)
		{
			RemoveCanvasMask(C);
		}

		if(Len(`NewLineChar) == 0)
		{
			DebugString @= "NewLine char is not specified!";
		}

		DrawDebugText(C, OutputPosition.X, OutputPosition.Y, DebugString, DebugColor);
	}
}

/**
 * UpdateDynamicProperties
 * Override
 * Singular because of UpdateText().
 */
singular function UpdateDynamicProperties()
{
	local KISVector2DUnsigned LineSize;
	local Vector2D OutputLineSize;

	// Recalculate fixed property
	OutputPosition = GetAdjustedPosition(Position, GetDrawMode(), Handle);
	// Add Position of Component
	OutputPosition.X += ParentComponent.OutputPosition.X;
	OutputPosition.Y += ParentComponent.OutputPosition.Y;

	// Recalculate fixed property
	OutputSize = GetAdjustedSize(Size, GetDrawMode(), Handle);

	// Calculate the output size of the text 
	LineSize.Y = LineLength;
	OutputLineSize = GetAdjustedSize(LineSize, GetDrawMode(), Handle);
	OutputLengthOfLine = OutputLineSize.Y;

	// When Init() calls this function first time, RenderedText is none
	// We update RenderedText because we need it in this function
	// UpdateText() calls again this function, that is why we need to use "singular"
	UpdateText(Text);

	// Apply anchor
	if(bEnableLineBreaking)
	{
		OutputPosition.X -= OutputLengthOfLine * Anchor.X;
		OutputPosition.Y -= WrappedTextHeight * Anchor.Y;
	}
	else
	{
		OutputPosition.X -= LongestLineWidth * Anchor.X;
		OutputPosition.Y -= WrappedTextHeight * Anchor.Y;
	}

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
	if(bEnableLineBreaking)
	{
		OutputMaskPosition.X += OutputLengthOfLine * MaskPositionInCO.X;
		OutputMaskPosition.Y += WrappedTextHeight * MaskPositionInCO.Y;
	}
	else
	{
		OutputMaskPosition.X += LongestLineWidth * MaskPositionInCO.X;
		OutputMaskPosition.Y += WrappedTextHeight * MaskPositionInCO.Y;
	}

	// Shape position
	if(bAutoFitShape)
	{
		// Automatic Input Shape properties
		OutputShapePosition = OutputPosition;

		if(bEnableLineBreaking)
		{
			OutputShapeSize.X = OutputLengthOfLine;
			OutputShapeSize.Y = WrappedTextHeight;
		}
		else
		{
			OutputShapeSize.X = LongestLineWidth;
			OutputShapeSize.Y = WrappedTextHeight;
		}
	}
	else
	{
		// Recalculate fixed property
		OutputShapeSize = GetAdjustedSize(ShapeSize, GetDrawMode(), Handle);
		// Recalculate fixed property
		OutputShapePosition = GetAdjustedPosition(ShapePositionOffset, GetDrawMode(), Handle);

		// Apply Shape Position In CO and Shape Anchor
		if(bEnableLineBreaking)
		{
			OutputShapePosition.X += OutputPosition.X + OutputLengthOfLine * ShapePositionInCO.X - OutputShapeSize.X * ShapeAnchor.X;
			OutputShapePosition.Y += OutputPosition.Y + WrappedTextHeight * ShapePositionInCO.Y - OutputShapeSize.Y * ShapeAnchor.Y;
		}
		else
		{
			OutputShapePosition.X += OutputPosition.X + LongestLineWidth * ShapePositionInCO.X - OutputShapeSize.X * ShapeAnchor.X;
			OutputShapePosition.Y += OutputPosition.Y + WrappedTextHeight * ShapePositionInCO.Y - OutputShapeSize.Y * ShapeAnchor.Y;
		}
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
	local string FoundString;
	local string S;

	if(NewText != "" && Len(`NewLineChar) > 0 && Font != none)
	{
		Text = NewText;
		RenderedText = Repl(Text, `NewLineChar, "", false);

		WrappedText = WrapString(NewText);
		
		WrappedTextWithoutNewLine.Length = 0;
		foreach WrappedText(FoundString)
		{
			S = Repl(FoundString, `NewLineChar, "", false);
			WrappedTextWithoutNewLine.AddItem(S);
		}

		WrappedTextHeight = WrappedTextWithoutNewLine.Length * GetMaxFontHeight();
		LongestLineWidth = GetWidthOfLongestLine(WrappedTextWithoutNewLine);
	}
	else
	{
		Text = "";
		RenderedText = "";
		WrappedText.Length = 0;
		WrappedTextWithoutNewLine.Length = 0;
		WrappedTextHeight = GetMaxFontHeight();
		LongestLineWidth = 0.f;
	}

	UpdateDynamicProperties();
}

/**
 * WrapString
 * Declaration
 * Breaks string into multiple lines depending on the NewLineCharacters and auto line breaking.
 * 
 * @param UnwrappedString
 * 
 * @return Wrapped string.
 */
function array<string> WrapString(string UnwrappedString)//, out string WrappedStringConnected)
{
	local array<string> Wrapped;
	local array<string> WordList;
	local string UnwrappedWithNewLineChars;
	local string CheckString;
	local string CheckStringWithoutNewLine;
	local bool bSuccessfulySplitedWord;
	local int NewLineCharPos;
	local int i;

	// Exchange possible \n for NewLineChar
	UnwrappedWithNewLineChars = Repl(UnwrappedString, Chr(10), `NewLineChar, false);
	UnwrappedWithNewLineChars = Repl(UnwrappedWithNewLineChars, Chr(13), `NewLineChar, false);
	
	// Is the automatic line breaking enabled ?
	if(bEnableLineBreaking)
	{
		// Break text into individual words
		WordList = SplitString(UnwrappedWithNewLineChars, " ", false);

		////////////////////////////////////////////////////
		// Break words that contain the new line character
		///////////////////////////////////////////////////
		for(i=0;i<WordList.Length;i++)
		{
			// Get the index of New Line Character in the current word
			NewLineCharPos = InStr(WordList[i], `NewLineChar, false, false);

			// Is New Line Character in this word ?
			if(NewLineCharPos != INDEX_NONE)
			{
				// Create place for the second part of the word
				WordList.Insert(i+1, 1);
				// Second part (contains New Line Character)
				WordList[i+1] = Right(WordList[i], Len(WordList[i]) - NewLineCharPos - 1);
				// First part - before New Line Char.. Contains special character Char(3) which indicates that this word is
				// broke just because of New Line Character than we do not need to put space after it
				WordList[i] = Chr(3)$Left(WordList[i], NewLineCharPos + 1);   ///// + 1
			}	
		}

		////////////////////////////////////////////
		// Main text check
		/////////////////////////////////////////
		for(i=0;i<WordList.Length;i++)
		{	
			// Is it a word or a space ?
			if(Len(WordList[i]) > 0)
			{
				////////////////////////////////////
				// Prepare word for checking
				///////////////////////////////////

				// Is it very last word ?
				if(i == WordList.Length - 1)
				{
					// There will not be next word so do not put space after this word
					CheckString = WordList[i];
				}
				else
				{
					// Is this word broke just because of New Line Char (contains Char(3))
					if(Left(WordList[i], 1) == Chr(3))
					{
						// Do not add a space and remove Char(3)
						CheckString = Right(WordList[i], Len(WordList[i])-1);
					}
					else
					{
						// This word is not last word, so add a space there
						CheckString = WordList[i] $ " ";
					}											
				}

				// Is New Line Char in the word ?
				if(Right(CheckString, 1) == `NewLineChar)
				{
					// Remove New Line Char
					CheckStringWithoutNewLine = Left(CheckString, Len(CheckString) - 1);
				}
				else
				{
					// Do not edit word
					CheckStringWithoutNewLine = CheckString;
				}

				///////////////////////////////////
				// Checking of the word
				///////////////////////////////////
				
				// Is word longer than line ?
				if(IsStringShorterThanLine(CheckStringWithoutNewLine))
				{
					// Is it very first word ?
					if(Wrapped.Length == 0)
					{
						// Let's create first line and put there this word
						Wrapped.Length = 1;
						Wrapped[0] = CheckString;
					}
					else
					{
						// Should this word be placed on the new line ?
						if(Right(Wrapped[Wrapped.Length - 1], 1) == `NewLineChar)
						{
							Wrapped.AddItem(CheckString);
						}
						else
						{
							// Can we add this word to the current line ?
							if(IsStringShorterThanLine(Repl(Wrapped[Wrapped.Length - 1], `NewLineChar, "", false)$CheckStringWithoutNewLine))
							{
								// Add it to the current line
								Wrapped[Wrapped.Length - 1] $= CheckString;
							}
							else
							{
								// No, this word will go on the new line
								Wrapped.AddItem(CheckString);
							}
						}
					}
				}
				else
				{
					// Word is longer than a line, we will brake it into smaller pieces
					// Does this word have more than one character
					if(Len(WordList[i]) > 1)
					{
						// Break word
						bSuccessfulySplitedWord = SplitWordOnEOL(Wrapped, CheckString);

						// Was breaking successful ?
						if(!bSuccessfulySplitedWord)
						{
							// ERROR
							`KiscanWarn(Tag$": Line length is too small, text will not display correctly!");
							break;
						}
					}
					else
					{
						// ERROR
						`KiscanWarn(Tag$": Line length is too small, text will not display correctly!");
						break;
					}
				}
			}
			else
			{
				// Is it very last word ?
				if(i != WordList.Length - 1)
				{
					// No, can we place a space on the new line ?
					if(IsStringShorterThanLine(" "))
					{
						// Does text start with s space ?
						if(Wrapped.Length > 0)
						{
							// No, can we add a space to the current line
							if(IsStringShorterThanLine(Repl(Wrapped[Wrapped.Length - 1], `NewLineChar, "", false) $ " "))
							{
								// Add it to the current line
								Wrapped[Wrapped.Length - 1] $= " ";
							}
							else
							{
								// Line is too small, place it on the new line
								Wrapped.AddItem(" ");
							}
						}
						else
						{
							// Space is the first character of the whole text
							Wrapped.Length = 1;
							Wrapped[0] = " ";
						}
					}
					else
					{
						// ERROR
						`KiscanWarn(Tag$": Line length is too small, text will not display correctly!");				
						break;
					}
				}
			}
		}
	}
	else
	{
		// Split string on new line characters
		Wrapped = SplitString(UnwrappedWithNewLineChars, `NewLineChar, false);
		
		// Add new line characters to the text
		for(i=0;i<Wrapped.Length-1;i++)
		{
			Wrapped[i] = Wrapped[i] $ `NewLineChar;
		}
	}

	return Wrapped;
}

/**
 * IsStringShorterThanLine
 * Declaration
 * Checks if S is longer than line.
 * 
 * @param S String to check.
 * 
 * @return True if string is shorter than line.
 */
function bool IsStringShorterThanLine(string S)
{
	local int XL, YL;
	local float XLF;

	if(Font != none)
	{
		Font.GetStringHeightAndWidth(S, YL, XL);
		XLF = XL * OutputSize.X * Font.GetScalingFactor(HUD.SizeY);
	}

	return XLF <= OutputLengthOfLine;
}

/**
 * SplitWordOnEOL
 * Declaration
 * Breaking of a word that is too big to be placed on the one line.
 * 
 * @param Wrapped Array where we will add splitted word.
 * @param S Word to split.
 * 
 * @return True if splitting was successfull.
 */
function bool SplitWordOnEOL(out array<string> Wrapped, string S)
{
	local bool bSuccessfulySplitedWord;
	local string LeftPart, RightPart;
	local int j;

	for(j=1;j<Len(S);j++)
	{	
		// Left part is Max Length - 1
		LeftPart = Left(S, Len(S) - j);
		// Right part is remaining part of the word
		RightPart = Right(S, j);

		// Can we place the left part on the line ?
		if(IsStringShorterThanLine(LeftPart))
		{
			// Yes, we can
			bSuccessfulySplitedWord = true;
			// Add the left part to the output array
			Wrapped.AddItem(LeftPart);

			if(!IsStringShorterThanLine(RightPart))
			{
				// ! Right part is still bigger than the line. We need to split that too.
				bSuccessfulySplitedWord = SplitWordOnEOL(Wrapped, RightPart);
			}	
			else
			{
				// Right part is ok, add it to the array
				Wrapped.AddItem(RightPart);
			}
			break;
		}
	}

	return bSuccessfulySplitedWord;
}

/**
 * GetWidthOfLongestLine
 * Declaration
 * Returns a width of the longest line in an array.
 * 
 * @param Wrapped Array to check.
 * 
 * @return Width of the longest line.
 */
function float GetWidthOfLongestLine(array<string> Wrapped)
{
	local int XL, YL;
	local float XLF;
	local string CurrentLine;
	local int i;

	if(Font != none)
	{
		for(i=0;i<WrappedTextWithoutNewLine.Length;i++)
		{
			CurrentLine = WrappedTextWithoutNewLine[i];
			Font.GetStringHeightAndWidth(CurrentLine, YL, XL);

			XLF = XL * OutputSize.X * Font.GetScalingFactor(HUD.SizeY);

			if(XLF > LongestLineWidth)
			{
				LongestLineWidth = XLF;
			}
		}
	}

	return LongestLineWidth;
}

/**
 * GetNewLineChar
 * Declaration
 * Returns New Line Characters.
 * 
 * @return New Line Character.
 */
function string GetNewLineChar()
{
	return Left(NewLineCharacter, 1);
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

defaultproperties
{
	Size=(X=1.f,Y=1.f)

	Text=`DefaultText
	Font=`DefaultFont
	TextColor=(R=255,G=255,B=255,A=255)
	LineLength=128
	NewLineCharacter="#"
}