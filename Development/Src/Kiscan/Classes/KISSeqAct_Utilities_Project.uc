/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Utilities_Project extends KISSequenceAction;

var(Project) Vector Location;
var(Project) editconst int ScreenX;
var(Project) editconst int ScreenY;

event Activated()
{
	local KISHUD CustomHUD;
	local Vector2D ScreenPos;

	super.Activated();

	CustomHUD = GetHUD();

	if(CustomHUD != none && CustomHUD.PlayerOwner != none && CustomHUD.PlayerOwner.Player != none && LocalPlayer(CustomHUD.PlayerOwner.Player) != none)
	{
		ScreenPos = LocalPlayer(CustomHUD.PlayerOwner.Player).Project(Location);
		ScreenX = CustomHUD.SizeX * ScreenPos.X;
		ScreenY = CustomHUD.SizeY * ScreenPos.Y;
	}
}

defaultproperties
{
	ObjName="Utilities > Project"

	VariableLinks(0)=(ExpectedType=class'SeqVar_Vector',LinkDesc="Location",PropertyName=Location,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Screen X",PropertyName=ScreenX)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Screen Y",PropertyName=ScreenY)
}