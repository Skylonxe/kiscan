/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Mouse_GetPosition extends KISSequenceAction;

var(Mouse_Position) editconst int X;
var(Mouse_Position) editconst int Y;

event Activated()
{
	local KISHUD CustomHUD;
	local Vector2D MousePosition;

	super.Activated();

	CustomHUD = GetHUD();

	if(CustomHUD != none)
	{
		MousePosition = CustomHUD.GetMousePosition();
		X = MousePosition.X;
		Y = MousePosition.Y;
	}
}

defaultproperties
{
	ObjName="Mouse > Get Position"

	VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="X",PropertyName=X,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Y",PropertyName=Y,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
}