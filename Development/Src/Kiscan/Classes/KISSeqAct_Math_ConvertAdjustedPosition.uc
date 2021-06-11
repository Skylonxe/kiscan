/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Math_ConvertAdjustedPosition extends KISSequenceAction;

var(Adjusted_Position) int AdjustedPositionX;
var(Adjusted_Position) int AdjustedPositionY;
var(Adjusted_Position) EKISDrawMode DrawMode;
var int DrawModeIdx;

var(Position) editconst int DynamicX;
var(Position) editconst int DynamicY;
var(Position) editconst float RelativeX;
var(Position) editconst float RelativeY;
var(Position) editconst int OffsetX;
var(Position) editconst int OffsetY;

event Activated()
{
	local KISHUD CustomHUD;
	local KISGUIPosition Position;
	local EKISDrawMode DM;
	
	super.Activated();

	CustomHUD = GetHUD();

	if(CustomHUD != none)
	{
		if(DrawModeIdx != -1)
		{
			DM = EKISDrawMode(Clamp(DrawModeIdx, 0, class'KISInfo'.static.GetEnumCount_EKISDrawMode()));
		}
		else
		{
			DM = DrawMode;
		}

		Position = class'KISObject'.static.ConvertAdjustedPosition(MakeIP(AdjustedPositionX, AdjustedPositionY), DM, CustomHUD.Handle);
		class'KISObject'.static.GetIndividualGUIPos(Position, DynamicX, DynamicY, RelativeX, RelativeY, OffsetX, OffsetY);
	}
}

defaultproperties
{
	ObjName="Math > Convert Adjusted Position"

	VariableLinks(0)=(ExpectedType=class'SeqVar_Int',LinkDesc="Adjusted Position X",PropertyName=AdjustedPositionX,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Adjusted Position Y",PropertyName=AdjustedPositionY,MaxVars=1)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Draw Mode",PropertyName=DrawModeIdx,MaxVars=1)

	VariableLinks(3)=(ExpectedType=class'SeqVar_Int',LinkDesc="Dynamic X",PropertyName=DynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Int',LinkDesc="Dynamic Y",PropertyName=DynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Float',LinkDesc="Relative X",PropertyName=RelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Float',LinkDesc="Relative Y",PropertyName=RelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Offset X",PropertyName=OffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Int',LinkDesc="Offset Y",PropertyName=OffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)

	DrawModeIdx=-1
}