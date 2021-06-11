/**
 * Kiscan GUI Framework
 * 
 * KISInput
 * 
 * Input class is the class which manages all inputs from the player.
 * See more at UDN.
 * 
 * Responsibilities of this class:
 * 
 * - Send input to the main class of Kiscan GUI framework - KISHandle.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISInput extends `{KiscanPlayerInputClass} within KISPlayerController;

/**
 * InputKey
 * Declaration
 * This function is called when the player presses some key. Called via delegate OnReceivedNativeInputKey.
 * For example, when the player presses the Tilde key the variable Key will be set to 'Tidle'.
 * It passes a call to KISHandle.
 * 
 * @param ControllerId The controller that generated this input key event.
 * @param Key The name of the key which an event occured for (Enter, LeftControl, X, K, etc.).
 * @param Event The type of event which occured (pressed, released, etc.).
 * @param AmountDepressed For analog keys, the depression percent.
 * @param bGamepad Input came from gamepad (ie xbox controller).
 *
 * @return Return true to indicate that the input event was handled. If the return value is true, this input event will not
 * be passed to the interactions array.
 */
function bool InputKey(int ControllerId, name Key, EInputEvent Event, optional float AmountDepressed = 1.f, optional bool bGamepad = false)
{
	local KISHandle Handle;
	local bool bTrap;
	
	if(myHUD != none && KISHUD(myHUD) != none)
	{
		Handle = KISHUD(myHUD).Handle;
	}
	
	if(Handle != none)
	{
		// Separate mouse input
		if(Key == 'LeftMouseButton' || Key == 'RightMouseButton' || Key == 'MiddleMouseButton' || Key == 'MouseScrollUp' || Key == 'MouseScrollDown')
		{
			bTrap = Handle.HandleMouseInput(Key, Event);
		}
		else
		{
			bTrap = Handle.HandleKeyInput(ControllerId, Key, Event, AmountDepressed, bGamepad);
		}
	}

	return bTrap;
}

/**
 * InputChar
 * Declaration
 * This function is called when the player presses some key. Called via delegate OnReceivedNativeInputChar.
 * For example, when the player presses the Tilde key the variable Unicode will be set to '~' (in english layout). Value of Unicode
 * depends on the keyboard layout of the user (diacritics, symbols and so on).
 * Useful when we want to write inside a text field.
 * It passes a call to KISHandle.
 * 
 * @param ControllerId The controller that generated this character input event.
 * @param Unicode The character that was typed.
 *
 * @return Return true to indicate that the input event was handled. If the return value is true, this input event will not
 * be passed to the interactions array.
 */
function bool InputChar(int ControllerId, string Unicode)
{
	local KISHandle Handle;
	local bool bTrap;
	
	if(myHUD != none && KISHUD(myHUD) != none)
	{
		Handle = KISHUD(myHUD).Handle;
	}
	
	if(Handle != none)
	{
		bTrap = Handle.HandleCharacterInput(ControllerId, Unicode);
	}

	return bTrap;
}

defaultproperties
{
	OnReceivedNativeInputKey=InputKey
	OnReceivedNativeInputChar=InputChar
}