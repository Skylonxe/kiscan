/**
 * Kiscan GUI Framework
 * 
 * It takes some time to update resolution so get resolution immediately after set res is not possible
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Viewport_GetResolution extends KISSequenceAction;

var(Resolution) editconst int ResolutionX;
var(Resolution) editconst int ResolutionY;

event Activated()
{
	local KISHUD CustomHUD;

	super.Activated();

	CustomHUD = GetHUD();

	if(CustomHUD != none)
	{
		ResolutionX = CustomHUD.SizeX;
		ResolutionY = CustomHUD.SizeY;
	}
}

defaultproperties
{
	ObjName="Viewport > Get Resolution"

	VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="Resolution X",PropertyName=ResolutionX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Resolution Y",PropertyName=ResolutionY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
}