/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSequenceAction extends SequenceAction
	abstract
	dependson(KISInfo);

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

function KISComponent GetComponentByTag(name CompTag)
{
	local KISHUD CustomHUD;
	local KISComponent ResultComp;

	if(CompTag != '')
	{
		CustomHUD = GetHUD();

		if(CustomHUD != none && CustomHUD.Handle != none && CustomHUD.Handle.Module.Length > 0 && CustomHUD.Handle.Module[0] != none)
		{
			ResultComp = CustomHUD.Handle.Module[0].GetComponentByTag(CompTag);
		}
	}
	
	return ResultComp;
}

function KISScene GetSceneByTag(name SceTag)
{
	local KISHUD CustomHUD;
	local KISScene ResultScene;

	if(SceTag != '')
	{
		CustomHUD = GetHUD();

		if(CustomHUD != none && CustomHUD.Handle != none && CustomHUD.Handle.Module.Length > 0 && CustomHUD.Handle.Module[0] != none)
		{
			ResultScene = CustomHUD.Handle.Module[0].GetSceneByTag(SceTag);
		}
	}

	return ResultScene;
}


final static function IntPoint MakeIP(int X, int Y)
{
	local IntPoint IP;

	IP.X = X;
	IP.Y = Y;

	return IP;
}

final static function KISGUIPosition MakeGUIPos(int DX, int DY, float RX, float RY, int OX, int OY)
{
	local KISGUIPosition Pos;

	Pos.Dynamic.X = DX;
	Pos.Dynamic.Y = DY;
	Pos.Relative.X = RX;
	Pos.Relative.Y = RY;
	Pos.Offset.X = OX;
	Pos.Offset.Y = OY;

	return Pos;
}

final static function Vector2D MakeVec2D(float X, float Y)
{
	local Vector2D V;

	V.X = X;
	V.Y = Y;

	return V;
}

final static function KISUVAbsolute MakeUVAbs(int U, int V, int UL, int VL)
{
	local KISUVAbsolute UV;

	UV.U = U;
	UV.V = V;
	UV.UL = UL;
	UV.VL = VL;

	return UV;
}

final static function KISUVNormalized MakeUVNorm(float U, float V, float UL, float VL)
{
	local KISUVNormalized UV;

	UV.U = U;
	UV.V = V;
	UV.UL = UL;
	UV.VL = VL;

	return UV;
}

defaultproperties
{
	ObjCategory="Kiscan"
	ObjColor=(R=80,G=130,B=250,A=255)

	VariableLinks.Empty
}