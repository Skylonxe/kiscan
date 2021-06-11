/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Math_ConvertAdjustedSize extends KISSequenceAction;

var(Adjusted_Size) float AdjustedSizeX<ClampMin=0.0>;
var(Adjusted_Size) float AdjustedSizeY<ClampMin=0.0>;
var(Adjusted_Size) EKISDrawMode DrawMode;
var int DrawModeIdx;

var(Position) editconst float SizeX;
var(Position) editconst float SizeY;

event Activated()
{
	local KISHUD CustomHUD;
	local KISVector2DUnsigned AdjustedSize;
	local Vector2D Size;
	local EKISDrawMode DM;
	
	super.Activated();

	CustomHUD = GetHUD();

	if(CustomHUD != none)
	{
		if(DrawModeIdx == -1)
		{
			DM = DrawMode;
		}
		else
		{
			DM = EKISDrawMode(Clamp(DrawModeIdx, 0, class'KISInfo'.static.GetEnumCount_EKISDrawMode() - 1));
		}
		
		AdjustedSize.X = FMax(AdjustedSizeX, 0.f);
		AdjustedSize.Y = FMax(AdjustedSizeY, 0.f);

		Size = class'KISObject'.static.ConvertAdjustedSize(AdjustedSize, DM, CustomHUD.Handle); 
		SizeX = Size.X;
		SizeY = Size.Y;
	}
}

defaultproperties
{
	ObjName="Math > Convert Adjusted Size"

	VariableLinks(0)=(ExpectedType=class'SeqVar_Float',LinkDesc="Adjusted Size X",PropertyName=AdjustedSizeX,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Float',LinkDesc="Adjusted Size Y",PropertyName=AdjustedSizeY,MaxVars=1)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Draw Mode",PropertyName=DrawModeIdx,MaxVars=1)

	VariableLinks(3)=(ExpectedType=class'SeqVar_Float',LinkDesc="Size X",PropertyName=SizeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Size Y",PropertyName=SizeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)

	DrawModeIdx=-1
}