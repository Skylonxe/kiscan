/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSequenceEvent extends SequenceEvent
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

defaultproperties
{
	MaxTriggerCount=0
	ReTriggerDelay=0.f
	bClientSideOnly=true

	ObjCategory="Kiscan"
	ObjColor=(R=35,G=85,B=180,A=255)
	VariableLinks.Empty
}