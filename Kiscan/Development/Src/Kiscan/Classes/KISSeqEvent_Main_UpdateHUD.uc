/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqEvent_Main_UpdateHUD extends KISSequenceEvent;

var float DeltaTime;

event Activated()
{
	local KISHUD HUD;

	super.Activated();

	HUD = GetHUD();

	if(HUD != none)
	{
		DeltaTime = HUD.RenderDelta;
	}
}

defaultproperties
{
	ObjName="Main > Update HUD"

	OutputLinks(0)=(LinkDesc="Loop")
	VariableLinks(0)=(ExpectedType=class'SeqVar_Float',LinkDesc="Delta Time",PropertyName=DeltaTime,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
}
