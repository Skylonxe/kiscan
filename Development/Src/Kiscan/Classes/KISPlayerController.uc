/**
 * Kiscan GUI Framework
 * 
 * KISPlayerController
 * 
 * PlayerController class is the basic class responsible for the player's movement.
 * See more at UDN.
 * 
 * Responsibilities of this class:
 * 
 * - Set up reference to the custom Input class.
 * - Handle some input functions.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISPlayerController extends `{KiscanPlayerControllerClass};

/**
 * SetConsoleKey
 * Declaration
 * Change the keybind which opens a small console. This is useful when you want to be able 
 * use default key (Tab) with eg TextInput component. Settings utilize this function.
 * 
 * @param KeyName Name of the new key. See list of available names at UDN.
 */
function SetConsoleKey(name KeyName)
{
	local Console PlayerConsole;
	local LocalPlayer LP;

	LP = LocalPlayer(Player);
	
	if(LP != none && LP.ViewportClient.ViewportConsole != none)
	{
		PlayerConsole = LP.ViewportClient.ViewportConsole;
		PlayerConsole.ConsoleKey = KeyName;
		PlayerConsole.SaveConfig();
	}
}

/**
 * SetTypeKey
 * Declaration
 * Change the keybind which opens a big console. This is useful when you want to be able 
 * use default key (Tilde) with eg TextInput component. Settings utilize this function.
 * 
 * @param KeyName Name of the new key. See list of available names at UDN.
 */
function SetTypeKey(name KeyName)
{
	local Console PlayerConsole;
	local LocalPlayer LP;

	LP = LocalPlayer(Player);
	
	if(LP != none && LP.ViewportClient.ViewportConsole != none)
	{
		PlayerConsole = LP.ViewportClient.ViewportConsole;
		PlayerConsole.TypeKey = KeyName;
		PlayerConsole.SaveConfig();
	}
}

defaultproperties
{
	InputClass=class'KISInput'
}