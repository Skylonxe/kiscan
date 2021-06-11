/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Mouse_SetPosition extends KISSequenceAction;

var(MousePosition) int X<ClampMin=0>;
var(MousePosition) int Y<ClampMin=0>;

event Activated()
{
	local KISHUD CustomHUD;

	super.Activated();

	CustomHUD = GetHUD();

	if(CustomHUD != none && CustomHUD.PlayerOwner != none && CustomHUD.PlayerOwner.Player != none && LocalPlayer(CustomHUD.PlayerOwner.Player) != none && LocalPlayer(CustomHUD.PlayerOwner.Player).ViewportClient != none)
	{
		LocalPlayer(CustomHUD.PlayerOwner.Player).ViewportClient.SetMouse(X, Y);
	}
}

defaultproperties
{
	ObjName="Mouse > Set Position"

	VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="X",PropertyName=X,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Y",PropertyName=Y,MaxVars=1)
}