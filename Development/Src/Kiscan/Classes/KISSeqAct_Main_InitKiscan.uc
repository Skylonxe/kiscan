/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hru�ovsk�, All Rights Reserved.
 */
class KISSeqAct_Main_InitKiscan extends KISSequenceAction;

var(Settings) KISSettings Settings;

event Activated()
{
	local KISHUD CustomHUD;

	CustomHUD = GetHUD();

	if(CustomHUD != none && Settings != none)
	{
		CustomHUD.InitKiscan(Settings);
	}
}

defaultproperties
{
	ObjName="Main > Init Kiscan"
}