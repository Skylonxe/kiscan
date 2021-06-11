/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSequenceCondition extends SequenceCondition
	abstract;

function KISHUD GetHUD()
{
	local WorldInfo WI;
	local KISHUD ResultHUD;

	WI = class'WorldInfo'.static.GetWorldInfo();

	if(WI != none && WI.GetALocalPlayerController() != none && WI.GetALocalPlayerController().myHUD != none && KISHUD(WI.GetALocalPlayerController().myHUD) != none)
	{
		ResultHUD = KISHUD(WI.GetALocalPlayerController().myHUD);
	}

	return ResultHUD;
}

function KISComponent GetComponentByTag(name CompTag)
{
	local KISHUD CustomHUD;
	local KISComponent ResultComp;

	if(CompTag != '')
	{
		CustomHUD = GetHUD();

		if(CustomHUD != none && CustomHUD.Handle != none && CustomHUD.Handle.Module.Length > 0 && CustomHUD.Handle.Module[0] != none)
		{
			ResultComp = CustomHUD.Handle.Module[0].GetComponentByTag(CompTag);
		}
	}
	
	return ResultComp;
}

defaultproperties
{
	ObjCategory="Kiscan"
	ObjColor=(R=20,G=25,B=180,A=255)
}