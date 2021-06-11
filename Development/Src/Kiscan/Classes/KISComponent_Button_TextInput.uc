/**
 * Kiscan GUI Framework
 * 
 * KISComponent_Button_TextInput
 * 
 * Text Input component represents a simple one line text field.
 * You can select it and then write inside.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISComponent_Button_TextInput extends KISComponent_Button;

/** Display scroll window size. */
var(Debug) bool bDrawScrollWindow;

/** Text inside the text input. */
var(Text_Input) string Text<MultilineWithMaxRows=10>;
/** Speed of the blinking of the caret. */
var(Text_Input) float CaretBlinkSpeed<ClampMin=0.0>;
/** True if we want to enable a the horizontal scrolling. */
var(Text_Input) bool bScroll;
/** Size of scrolling window determines how long text can be displayed when bScroll is enabled. */
var(Text_Input) int ScrollWindowSize<ClampMin=1>;

/** This CO text draws when you do nothing with this text input. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectSpecial_SimpleText COSpecial_IdleText<DisplayName="CO Special - Idle Text">;
/** This CO text draws when your mouse cursor is on the text input. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectSpecial_SimpleText COSpecial_HoverText<DisplayName="CO Special - Hover Text">;
/** This CO text draws when the text input is selected. */
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectSpecial_SimpleText COSpecial_ClickedText<DisplayName="CO Special - Clicked Text">;
/** Caret shows when the input is selected. Caret is object which shows on the position where you will write a new text.*/
var(Lists_of_Canvas_Objects) instanced editconst const KISCanvasObjectSpecial COSpecial_Caret<DisplayName="CO Special - Caret">;

/** Final scroll window size of this component in pixels. */
var float OutputScrollWindowSize;

/** Current position of caret. One idx represents one character in text. */
var int CaretPositionIdx;
/** First character which can be rendered because of bScroll. */
var int ScrollPositionIdx;

/**
 * Init
 * Override
 */
function Init(KISHUD NewHUD, KISHandle NewHandle, KISModule NewModule, KISScene NewParentScene)
{
	super.Init(NewHUD, NewHandle, NewModule, NewParentScene);

	PublishTextToCO();
	MoveCaretOnIdx(Len(Text));
}

/**
 * LoadCOSpecial
 * Override
 */
function LoadCOSpecial()
{
	super.LoadCOSpecial();

	COSpecial.AddItem(COSpecial_IdleText);
	COSpecial.AddItem(COSpecial_HoverText);
	COSpecial.AddItem(COSpecial_ClickedText);
	COSpecial.AddItem(COSpecial_Caret);
}

/**
 * Update
 * Override
 */
function Update(float DeltaTime)
{
	local KISCanvasObject ClickedTextCO;
	local KISCanvasObject CaretCO;

	super.Update(DeltaTime);

	if(ButtonState == BS_Clicked && Handle.SelectedComponent != self)
	{
		// Deselect text
		if(bMouseHover)
		{
			SetButtonState(BS_Hover);
		}
		else
		{
			SetButtonState(BS_Idle);
		}
	}

	// Update text in CO
	PublishTextToCO();

	if(ButtonState == BS_Clicked)
	{
		// Update position of caret co
		CaretCO = GetCOSpecialByTag('Caret').CanvasObject;
		ClickedTextCO = GetCOSpecialByTag('ClickedText').CanvasObject;

		if(CaretCO != none && ClickedTextCO != none)
		{
			if(bScroll)
			{
				CaretCO.OutputPosition = KISCanvasObject_SimpleText(ClickedTextCO).GetCharPosition(KISCanvasObject_SimpleText(ClickedTextCO).Text, CaretPositionIdx - ScrollPositionIdx);
			}
			else
			{
				CaretCO.OutputPosition = KISCanvasObject_SimpleText(ClickedTextCO).GetCharPosition(Text, CaretPositionIdx);
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
	local KISCanvasObject ClickedTextCO;

	super.RenderDebug(C, DeltaTime);

	if(bEnabled)
	{
		if(bDrawScrollWindow && bScroll)
		{
			ClickedTextCO = GetCOSpecialByTag('ClickedText').CanvasObject;

			if(ClickedTextCO != none)
			{
				C.SetPos(ClickedTextCO.OutputPosition.X, ClickedTextCO.OutputPosition.Y);
				C.SetDrawColorStruct(DebugColor);
				C.DrawBox(OutputScrollWindowSize, KISCanvasObject_SimpleText(ClickedTextCO).GetMaxFontHeight());
			}
		}
	}
}

/**
 * UpdateDynamicProperties
 * Override
 */
function UpdateDynamicProperties()
{
	local KISVector2DUnsigned ScrollWindowsSizeIP;
	local Vector2D ScrollWindowSizeV2D;

	super.UpdateDynamicProperties();

	ScrollWindowsSizeIP.X = ScrollWindowSize;
	ScrollWindowSizeV2D = GetAdjustedSize(ScrollWindowsSizeIP, GetDrawMode(), Handle);
	OutputScrollWindowSize = ScrollWindowSizeV2D.X;
}

/**
 * HandleCharacterInput
 * Override
 */
function bool HandleCharacterInput(int ControllerId, string Unicode)
{
	local bool bTrapInput;

	super.HandleCharacterInput(ControllerID, Unicode);

	if(ButtonState == BS_Clicked)
	{
		switch(Unicode)
		{
			case Chr(8): // Backspace
				DeleteCharacter(false);
				break;
			case Chr(9): // Tab
				TypeText(Chr(9));
				break;
			case Chr(10): // Enter
 			case Chr(13):
			case Chr(27):
				Handle.SelectedComponent = none;
				break;
			case Chr(127): // Delete
				break;
			default: // Normal character
				if(Asc(Unicode) >= 32)
				{
					TypeText(Unicode);
				}
				break;
		}		

		bTrapInput = true;
	}

	return bTrapInput;
}

/**
 * HandleKeyInput
 * Override
 */
function bool HandleKeyInput(int ControllerId, name Key, EInputEvent Event, int AmountDepressed, bool bGamepad)
{
	local bool bTrapInput;

	if(ButtonState == BS_Clicked)
	{
		if(Event == IE_Pressed || Event == IE_Repeat)
		{
			switch(Key)
			{
				case 'Left': // Move the caret the left
					MoveCaretOnIdx(CaretPositionIdx - 1);
					break;
				case 'Right': // Move the caret the right
					MoveCaretOnIdx(CaretPositionIdx + 1);
					break;
				case 'Home': // Move the caret to the start
					if(!Handle.bAltPressed)
					{
						MoveCaretOnIdx(0);
					}
					break;
				case 'End': // Move the caret to the end
					if(!Handle.bAltPressed)
					{
						MoveCaretOnIdx(Len(Text));
					}
					break;
				case 'Insert':
					if(Handle.bCtrlPressed && !Handle.bAltPressed)
					{
						// + CTRL, Copy
						HUD.PlayerOwner.CopyToClipboard(GetSelectedText());
					}
					else if(Handle.bShiftPressed)
					{
						// + SHIFT, Paste
						TypeText(HUD.PlayerOwner.PasteFromClipboard());
					}
					else
					{
						// Toggle overtype mode
						Handle.SetTextOvertypeMode(!Handle.bTextOvertypeMode);
					}
					break;
				case 'Delete': // Delete text
					DeleteCharacter(true);
					break;
				case 'X':
					if(Handle.bCtrlPressed && !Handle.bAltPressed)
					{
						// +CTRL, Cut
						HUD.PlayerOwner.CopyToClipboard(DeleteSelectedText());
					}
					break;
				case 'C':
					if(Handle.bCtrlPressed && !Handle.bAltPressed)
					{
						// +CTRL, Copy
						HUD.PlayerOwner.CopyToClipboard(GetSelectedText());
					}
					break;
				case 'V':
					if(Handle.bCtrlPressed && !Handle.bAltPressed)
					{
						// +CTRL, Paste
						TypeText(HUD.PlayerOwner.PasteFromClipboard());
					}
					break;
				default:
					break;
			}
		}

		bTrapInput = true;
	}

	if(!bTrapInput)
	{
		bTrapInput = super.HandleKeyInput(ControllerId, Key, Event, AmountDepressed, bGamepad);
	}
	else
	{
		super.HandleKeyInput(ControllerId, Key, Event, AmountDepressed, bGamepad);
	}

	return bTrapInput;
}

/**
 * PressButton
 * Override
 */
function PressButton()
{
	if(ButtonState != BS_Clicked)
	{
		if(bUsePressInsteadRelease)
		{
			ButtonActivated();
			SetButtonState(BS_Clicked);
		}
	}
}

/**
 * ReleaseButton
 * Override
 */
function ReleaseButton()
{
	if(ButtonState != BS_Clicked)
	{
		if(!bUsePressInsteadRelease)
		{
			ButtonActivated();
			SetButtonState(BS_Clicked);
		}
	}
}

/**
 * ButtonActivated
 * Override
 * Select a text input.
 */
function ButtonActivated()
{
	super.ButtonActivated();

	Handle.SelectedComponent = self;
}

/**
 * SetButtonState
 * Override
 */
function SetButtonState(EKISButtonState NewButtonState)
{
	super.SetButtonState(NewButtonState);

	switch(NewButtonState)
	{
		case BS_Idle:
			GetCOSpecialByTag('IdleText').bRender = true;
			GetCOSpecialByTag('HoverText').bRender = false;
			GetCOSpecialByTag('ClickedText').bRender = false;
			break;
		case BS_Hover:
			GetCOSpecialByTag('IdleText').bRender = false;
			GetCOSpecialByTag('HoverText').bRender = true;
			GetCOSpecialByTag('ClickedText').bRender = false;
			break;
		case BS_Clicked:
			GetCOSpecialByTag('IdleText').bRender = false;
			GetCOSpecialByTag('HoverText').bRender = false;
			GetCOSpecialByTag('ClickedText').bRender = true;
			break;
		default:
			break;
	}
	
	if(ButtonState == BS_Clicked)
	{
		// Show the caret
		GetCOSpecialByTag('Caret').bRender = true;

		HUD.SetTimer(CaretBlinkSpeed, true, 'TimerToggleCaret', self);
	}
	else
	{
		// Hide the caret
		GetCOSpecialByTag('Caret').bRender = false;

		HUD.ClearTimer('TimerToggleCaret', self);
	}
}

/**
 * MoveCaretOnIdx
 * Declaration
 * Move the caret to some character.
 * 
 * @param Idx Index of the character where we want to move the caret.
 * */
function MoveCaretOnIdx(int Idx)
{
	local KISCanvasObject_SimpleText ClickedTextCO;
	local float ScrollToCaretDistance;
	local int OldCaretIdx;

	if(GetCOSpecialByTag('ClickedText').CanvasObject != none)
	{
		ClickedTextCO = KISCanvasObject_SimpleText(GetCOSpecialByTag('ClickedText').CanvasObject);
	}

	OldCaretIdx = CaretPositionIdx;
	CaretPositionIdx = Clamp(Idx, 0, Len(Text));

	if(ClickedTextCO != none)
	{
		// Try to update the scroll position
		if(OldCaretIdx < CaretPositionIdx)
		{
			ScrollToCaretDistance = ClickedTextCO.GetWidthOfString(Mid(Text, ScrollPositionIdx, CaretPositionIdx - ScrollPositionIdx));

			while(ScrollToCaretDistance > OutputScrollWindowSize)
			{
				ScrollPositionIdx++;
				ScrollToCaretDistance = ClickedTextCO.GetWidthOfString(Mid(Text, ScrollPositionIdx, CaretPositionIdx - ScrollPositionIdx));
			}
		}
		else if(OldCaretIdx > CaretPositionIdx)
		{
			while(ScrollPositionIdx > CaretPositionIdx)
			{
				ScrollPositionIdx--;
			}
		}
	}
}

/**
 * TypeText
 * Declaration
 * Add text to current one on the position of the caret.
 * 
 * @param T Additional text.
 */
function TypeText(string T)
{
	local string OldText;

	if(Len(T) > 0)
	{
		OldText = Text;

		Text = Left(OldText, CaretPositionIdx);
		Text $= T;

		if(Handle.bTextOvertypeMode)
		{
			Text $= Right(OldText, Len(OldText) - CaretPositionIdx - 1);
		}
		else
		{
			Text $= Right(OldText, Len(OldText) - CaretPositionIdx);
		}

		PublishTextToCO();

		MoveCaretOnIdx(CaretPositionIdx + Len(T));
	}
}

/**
 * SetText
 * Declaration
 * Replace the whole text.
 * 
 * @param T New text.
 */
function SetText(string T)
{
	Text = T;
	PublishTextToCO();
	MoveCaretOnIdx(0);
}

/**
 * DeleteCharacter
 * Declaration
 * Delete one character.
 * 
 * @param bRight True if we want to delete a character on the right (eg because of Delete key).
 */
function DeleteCharacter(bool bRight)
{
	local string OldText;
	local KISCanvasObject_SimpleText ClickedTextCO;
	local string CheckStr;
	local int AddCharCount;

	if(GetCOSpecialByTag('ClickedText').CanvasObject != none)
	{
		ClickedTextCO = KISCanvasObject_SimpleText(GetCOSpecialByTag('ClickedText').CanvasObject);
	}

	OldText = Text;

	if(bRight)
	{
		Text = Left(OldText, CaretPositionIdx);
		Text $= Right(OldText, Len(OldText) - CaretPositionIdx - 1);

		MoveCaretOnIdx(CaretPositionIdx);
	}
	else
	{
		Text = Left(OldText, CaretPositionIdx - 1);
		Text $= Right(OldText, Len(OldText) - CaretPositionIdx);

		MoveCaretOnIdx(CaretPositionIdx - 1);
	}

	if(ClickedTextCO != none)
	{
		CheckStr = Mid(Text, ScrollPositionIdx, Len(ClickedTextCO.Text));
		AddCharCount = 0;
		while(ClickedTextCO.GetWidthOfString(CheckStr) <= OutputScrollWindowSize && ScrollPositionIdx > 0)
		{
			AddCharCount++;
			ScrollPositionIdx--;

			CheckStr = Mid(Text, ScrollPositionIdx, Len(ClickedTextCO.Text) + AddCharCount);

			if(ClickedTextCO.GetWidthOfString(CheckStr) > OutputScrollWindowSize)
			{
				ScrollPositionIdx++;
				break;
			}
		}
	}
}

/**
 * TimerToggleCaret
 * Declaration
 * Timer which continually toggles the caret on and off.
 */
function TimerToggleCaret()
{
	local KISCanvasObjectSpecial CaretCOSpecial;

	CaretCOSpecial = GetCOSpecialByTag('Caret');
	CaretCOSpecial.bRender = !CaretCOSpecial.bRender;
}

/**
 * GetSelectedText
 * Declaration
 * Not implemented yet. This should return the current selected text.
 * 
 * @return Whole text.
 */
function string GetSelectedText()
{
	return Text;
}

/**
 * DeleteSelectedText
 * Declaration
 * Not implemented yet. This should delete the current selected text.
 * 
 * @return Deleted text.
 */
function string DeleteSelectedText()
{
	local string DeletedText;

	DeletedText = Text;
	Text = "";
	MoveCaretOnIdx(0);

	return DeletedText;
}

/**
 * PublishTextToCO
 * Declaration
 * Set the text in the text CO to the same value as the Text variable in the Text Input.
 */
function PublishTextToCO()
{
	local KISCanvasObject IdleTextCO, HoverTextCO, ClickedTextCO;
	local string ClampedText;
	
	IdleTextCO = GetCOSpecialByTag('IdleText').CanvasObject;
	HoverTextCO = GetCOSpecialByTag('HoverText').CanvasObject;
	ClickedTextCO = GetCOSpecialByTag('ClickedText').CanvasObject;	

	if(IdleTextCO != none)
	{
		ClampedText = KISCanvasObject_SimpleText(IdleTextCO).ClampTextByWidth(Text, OutputScrollWindowSize);

		if(KISCanvasObject_SimpleText(IdleTextCO).Text != ClampedText)
		{
			KISCanvasObject_SimpleText(IdleTextCO).UpdateText(ClampedText);
		}
	}

	if(HoverTextCO != none)
	{
		ClampedText = KISCanvasObject_SimpleText(HoverTextCO).ClampTextByWidth(Text, OutputScrollWindowSize);

		if(KISCanvasObject_SimpleText(HoverTextCO).Text != ClampedText)
		{
			KISCanvasObject_SimpleText(HoverTextCO).UpdateText(ClampedText);
		}
	}

	if(ClickedTextCO != none)
	{
		ClampedText = GetScrolledText(KISCanvasObject_SimpleText(ClickedTextCO), Text);

		if(KISCanvasObject_SimpleText(ClickedTextCO).Text != ClampedText)
		{
			KISCanvasObject_SimpleText(ClickedTextCO).UpdateText(ClampedText);
		}
	}
}

/**
 * GetScrolledText
 * Declaration
 * Return current displayed text. This can be just part of Text because
 * we can show only scrolled part of text.
 * 
 * @param TextCO Text CO used for check. Different Text CO can return different results because of the size of the text and the scroll window size.
 * @param T Whole text (usually Text variable).
 * 
 * @return Current displayed text.
 */
function string GetScrolledText(KISCanvasObject_SimpleText TextCO, string T)
{
	local string Result;
	local string CurrentText;
	local string NewText;
	local int TextLength;
	local int i;

	if(bScroll && TextCO != none)
	{
		TextLength = 0;
		NewText = "";
		for(i=0;TextLength<=OutputScrollWindowSize;i++)
		{
			CurrentText = NewText;
			NewText = Mid(T, ScrollPositionIdx, i);
			TextLength = TextCO.GetWidthOfString(NewText);

			if(ScrollPositionIdx + Len(CurrentText) == Len(T))
			{
				break;
			}
		}
		
		Result = CurrentText;
	}
	else
	{
		Result = T;
	}

	return Result;
}

/**
 * Destroy
 * Override
 */
function Destroy()
{
	HUD.ClearTimer('TimerToggleCaret', self);

	super.Destroy();
}

defaultproperties
{
	bCaptureCharacterInput=true

	bUsePressInsteadRelease=true

	Begin Object Class=KISCanvasObjectSpecial_SimpleText Name=COSpecial_IdleText
		Tag=IdleText
		bRender=false
	End Object
	COSpecial_IdleText=COSpecial_IdleText

	Begin Object Class=KISCanvasObjectSpecial_SimpleText Name=COSpecial_HoverText
		Tag=HoverText
		bRender=false
	End Object
	COSpecial_HoverText=COSpecial_HoverText

	Begin Object Class=KISCanvasObjectSpecial_SimpleText Name=COSpecial_ClickedText
		Tag=ClickedText
		bRender=false
	End Object
	COSpecial_ClickedText=COSpecial_ClickedText

	Begin Object Class=KISCanvasObjectSpecial_All Name=COSpecial_Caret
		Tag=Caret
		bRender=false
	End Object
	COSpecial_Caret=COSpecial_Caret

	CaretBlinkSpeed=0.5f
	ScrollWindowSize=128
}

