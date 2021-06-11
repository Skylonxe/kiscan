/**
 * Kiscan GUI Framework
 * 
 * It takes some time to update resolution so get resolution immediately after set res is not possible
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Viewport_SetResolution extends KISSequenceAction;

var(Resolution) int ResolutionX<ClampMin=1>;
var(Resolution) int ResolutionY<ClampMin=1>;

event Activated()
{
	local KISHUD CustomHUD;

	super.Activated();

	CustomHUD = GetHUD();

	if(CustomHUD != none && Abs(ResolutionX) > 0.f && Abs(ResolutionY) > 0.f)
	{
		CustomHUD.ConsoleCommand("Scale Set ResX"@FFloor(Abs(ResolutionX)));
		CustomHUD.ConsoleCommand("Scale Set ResY"@FFloor(Abs(ResolutionY)));
	}
}

defaultproperties
{
	ObjName="Viewport > Set Resolution"

	VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="Resolution X",PropertyName=ResolutionX,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Resolution Y",PropertyName=ResolutionY,MaxVars=1)
}