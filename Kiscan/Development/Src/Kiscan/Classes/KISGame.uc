/**
 * Kiscan GUI Framework
 * 
 * KISGame
 * 
 * Game class is the most important class of a game. It manages variables like a score and so on.
 * See more at UDN.
 * 
 * Responsibilities of this class:
 * 
 * - Set up reference to the custom HUD class.
 * - Set up reference to the custom PlayerController class.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISGame extends `{KiscanGameInfoClass}; 

defaultproperties
{
	HUDType=class'KISHUD'
	PlayerControllerClass=class'KISPlayerController'

	`if(`isdefined(KISParentProject_UTGame_ClassicHUD))
		bUseClassicHUD=true
	`else
		`if(`isdefined(KISParentProject_UTGame_ScaleformHUD))
			bUseClassicHUD=true
		`else
		`endif
	`endif
}