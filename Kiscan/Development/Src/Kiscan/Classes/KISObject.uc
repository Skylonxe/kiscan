/**
 * Kiscan GUI Framework
 * 
 * KISObject
 * 
 * KISObject is the base class for most of kiscan classes. It contains many useful
 * functions. Usually there are functions for converting and so on.
 * 
 * Responsibilities of this class:
 * 
 * - Provide reusable useful functions.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISObject extends Object
	abstract
	dependson(KISInfo)
	hidecategories(Object);

/**
 * Vec2IP
 * Declaration
 * Convert Vector2D(X,Y) to IntPoint(X,Y).
 * 
 * @param V Vector2D to convert.
 * 
 * @return Converted V2D to IP.
 */
final static function IntPoint Vec2IP(Vector2D V)
{
	local IntPoint IP;

	// Rounding does not happen
	// We use FFloor() because simple Int = Float typecast is slow
	IP.X = FFloor(V.X);
	IP.Y = FFloor(V.Y);

	return IP;
}

/**
 * MakeIP
 * Declaration
 * Convert two int values to one IntPoint.
 * 
 * @param X Value for X.
 * @param Y Value for Y.
 * 
 * @return New IntPoint.
 */
final static function IntPoint MakeIP(int X, int Y)
{
	local IntPoint IP;

	IP.X = X;
	IP.Y = Y;

	return IP;
}

/**
 * MakeGUIPos
 * Declaration
 * Create KISGUIPosition from independent values.
 * 
 * @param DX Dynamic X.
 * @param DY Dynamic Y.
 * @param RX Relative X.
 * @param RY Relative Y.
 * @param OX Offset X.
 * @param OY Offset Y.
 * 
 * @return Newly created KISGUIPosition.
 */
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

/**
 * MakeVec2D
 * Declaration
 * Create Vector2D from independent values.
 * 
 * @param X Value for X.
 * @param Y Value for Y.
 * 
 * @return Newly created Vector2D.
 */
final static function Vector2D MakeVec2D(float X, float Y)
{
	local Vector2D V;

	V.X = X;
	V.Y = Y;

	return V;
}

/**
 * GetIndividualGUIPos
 * Declaration
 * Break KISGUIPosition into independent values.
 * 
 * @param Pos KISGUIPosition which will be broke.
 * @param Out_DX Dynamic X.
 * @param Out_DY Dynamic Y.
 * @param Out_RX Relative X.
 * @param Out_RY Relative Y.
 * @param Out_OX Offset X.
 * @param Out_OY Offset Y.
 */
final static function GetIndividualGUIPos(KISGUIPosition Pos, out int Out_DX, out int Out_DY, out float Out_RX, out float Out_RY, out int Out_OX, out int Out_OY)
{
	Out_DX = Pos.Dynamic.X;
	Out_DY = Pos.Dynamic.Y;
	Out_RX = Pos.Relative.X;
	Out_RY = Pos.Relative.Y;
	Out_OX = Pos.Offset.X;
	Out_OY = Pos.Offset.Y;
}

/**
 * GetAdjustedPosition
 * Declaration
 * Change a position based on Draw Mode. KISHandle is required for these calculations.
 * We use this to update the position when player changes the resolution.
 * 
 * @param Pos Position which will be changed.
 * @param DM Draw mode used to determine type of a change.
 * @param Handle Reference to the handle because we need to have an access to properties of the screen.
 * 
 * @return Updated position.
 */
final static function IntPoint GetAdjustedPosition(KISGUIPosition Pos, EKISDrawMode DM, KISHandle Handle)
{
	local float ShowAllSizeY, NoBorderSizeX;
	local IntPoint Result;

	if(Handle != none && Handle.Settings != none && Handle.HUD != none)
	{
		switch(DM)
		{
			case DM_NoScale:
				Result.X = Pos.Dynamic.X + Pos.Relative.X * Handle.Settings.NativeResolution.X + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y + Pos.Relative.Y * Handle.Settings.NativeResolution.Y + Pos.Offset.Y;
				break;
			case DM_ExactFit:
				Result.X = Pos.Dynamic.X * Handle.ScreenRatio.X + Pos.Relative.X * Handle.HUD.SizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y * Handle.ScreenRatio.Y + Pos.Relative.Y * Handle.HUD.SizeY + Pos.Offset.Y;
				break;
			case DM_ShowAll:
				ShowAllSizeY = Handle.HUD.SizeX * (float(Handle.Settings.NativeResolution.Y) / Handle.Settings.NativeResolution.X);

				Result.X = Pos.Dynamic.X * Handle.ScreenRatio.X + Pos.Relative.X * Handle.HUD.SizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y * Handle.ScreenRatio.X + Pos.Relative.Y * ShowAllSizeY + Pos.Offset.Y;
				break;
			case DM_NoBorder:
				NoBorderSizeX = Handle.HUD.SizeY * (float(Handle.Settings.NativeResolution.X) / Handle.Settings.NativeResolution.Y);

				Result.X = Pos.Dynamic.X * Handle.ScreenRatio.Y + Pos.Relative.X * NoBorderSizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y * Handle.ScreenRatio.Y + Pos.Relative.Y * Handle.HUD.SizeY + Pos.Offset.Y;
				break;
			case DM_Relative:
				Result.X = Pos.Dynamic.X + Pos.Relative.X * Handle.HUD.SizeX + Pos.Offset.X;
				Result.Y = Pos.Dynamic.Y + Pos.Relative.Y * Handle.HUD.SizeY + Pos.Offset.Y;
				break;
			default:
				break;
		}
	}

	return Result;
}

/**
 * GetAdjustedSize
 * Declaration
 * Change a size based on Draw Mode. KISHandle is required for these calculations.
 * We use this to update the size when player changes the resolution.
 * For example when you have 100x100 picture but you use a high resolution with a scaling enabled, the returned size
 * will be 120x120. For more about a scaling based on Draw Mode see Kiscan Documentation.
 * 
 * @param S Size which will be changed.
 * @param DM Draw mode used to determine type of a change.
 * @param Handle Reference to the handle because we need to have an access to properties of the screen.
 * 
 * @return Updated size.
 */
final static function Vector2D GetAdjustedSize(KISVector2DUnsigned S, EKISDrawMode DM, KISHandle Handle)
{
	local Vector2D Result;

	S.X = Abs(S.X);
	S.Y = Abs(S.Y);

	if(Handle != none)
	{
		switch(DM)
		{
			case DM_NoScale:
				Result.X = S.X;
				Result.Y = S.Y;
				break;
			case DM_ExactFit:
				Result.X = S.X * Handle.ScreenRatio.X;
				Result.Y = S.Y * Handle.ScreenRatio.Y;
				break;
			case DM_ShowAll:
				Result.X = S.X * Handle.ScreenRatio.X;
				Result.Y = S.Y * Handle.ScreenRatio.X;
				break;
			case DM_NoBorder:
				Result.X = S.X * Handle.ScreenRatio.Y;
				Result.Y = S.Y * Handle.ScreenRatio.Y;
				break;
			case DM_Relative:
				Result.X = S.X;
				Result.Y = S.Y;
				break;
			default:
				break;
		}
	}

	return Result;
}

/**
 * ConvertAdjustedSize
 * Declaration
 * Inverted GetAdjustedSize(). Return size before a change based on Draw Mode.
 * This is not absolutly accurate because of Int/Float typecasts.
 * 
 * @param AdjustedSize Size which will be converted to orignal one.
 * @param DM Draw mode used to determine type of a change.
 * @param Handle Reference to the handle because we need to have an access to properties of the screen.
 * 
 * @return Orignal size.
 */
final static function Vector2D ConvertAdjustedSize(KISVector2DUnsigned AdjustedSize, EKISDrawMode DM, KISHandle Handle)
{
	local Vector2D Result;

	AdjustedSize.X = Abs(AdjustedSize.X);
	AdjustedSize.Y = Abs(AdjustedSize.Y);

	if(Handle != none)
	{
		switch(DM)
		{
			case DM_NoScale:
				Result.X = AdjustedSize.X;
				Result.Y = AdjustedSize.Y;
				break;
			case DM_ExactFit:
				Result.X = AdjustedSize.X / Handle.ScreenRatio.X;
				Result.Y = AdjustedSize.Y / Handle.ScreenRatio.Y;
				break;
			case DM_ShowAll:
				Result.X = AdjustedSize.X / Handle.ScreenRatio.X;
				Result.Y = AdjustedSize.Y / Handle.ScreenRatio.X;
				break;
			case DM_NoBorder:
				Result.X = AdjustedSize.X / Handle.ScreenRatio.Y;
				Result.Y = AdjustedSize.Y / Handle.ScreenRatio.Y;
				break;
			case DM_Relative:
				Result.X = AdjustedSize.X;
				Result.Y = AdjustedSize.Y;
				break;
			default:
				break;
		}
	}

	return Result;
}

/**
 * ConvertAdjustedPosition
 * Declaration
 * Inverted GetAdjustedPosition(). Return position before a change based on Draw Mode.
 * This is not absolutly accurate because of Int/Float typecasts.
 * 
 * @param AdjustedPosition Position which will be converted to orignal one.
 * @param DM Draw mode used to determine type of a change.
 * @param Handle Reference to the handle because we need to have an access to properties of the screen.
 * 
 * @return Orignal position.
 */
final static function KISGUIPosition ConvertAdjustedPosition(IntPoint AdjustedPosition, EKISDrawMode DM, KISHandle Handle)
{
	local float ShowAllSizeY, NoBorderSizeX;
	local KISGUIPosition Result;

	if(Handle != none && Handle.Settings != none && Handle.HUD != none)
	{
		switch(DM)
		{
			case DM_NoScale:				
				Result.Dynamic.X = AdjustedPosition.X;
				Result.Dynamic.Y = AdjustedPosition.Y;
				Result.Relative.X = AdjustedPosition.X / float(Handle.Settings.NativeResolution.X);
				Result.Relative.Y = AdjustedPosition.Y / float(Handle.Settings.NativeResolution.Y);
				Result.Offset.X = AdjustedPosition.X;
				Result.Offset.Y = AdjustedPosition.Y;
				break;
			case DM_ExactFit:
				Result.Dynamic.X = AdjustedPosition.X / Handle.ScreenRatio.X;
				Result.Dynamic.Y = AdjustedPosition.Y / Handle.ScreenRatio.Y;
				Result.Relative.X = AdjustedPosition.X / Handle.HUD.SizeX;
				Result.Relative.Y = AdjustedPosition.Y / Handle.HUD.SizeY;
				Result.Offset.X = AdjustedPosition.X;
				Result.Offset.Y = AdjustedPosition.Y;
				break;
			case DM_ShowAll:
				ShowAllSizeY = Handle.HUD.SizeX * (float(Handle.Settings.NativeResolution.Y) / Handle.Settings.NativeResolution.X);

				Result.Dynamic.X = AdjustedPosition.X / Handle.ScreenRatio.X;
				Result.Dynamic.Y = (AdjustedPosition.Y - (Handle.HUD.SizeY - ShowAllSizeY) / 2.f) / Handle.ScreenRatio.X;
				Result.Relative.X = AdjustedPosition.X / Handle.HUD.SizeX;
				Result.Relative.Y = (AdjustedPosition.Y - (Handle.HUD.SizeY - ShowAllSizeY) / 2.f) / ShowAllSizeY;
				Result.Offset.X = AdjustedPosition.X;
				Result.Offset.Y = AdjustedPosition.Y - (Handle.HUD.SizeY - ShowAllSizeY) / 2.f;
				break;
			case DM_NoBorder:
				NoBorderSizeX = Handle.HUD.SizeY * (float(Handle.Settings.NativeResolution.X) / Handle.Settings.NativeResolution.Y);
	
				Result.Dynamic.X = (AdjustedPosition.X - (Handle.HUD.SizeX - NoBorderSizeX) / 2.f) / Handle.ScreenRatio.Y;
				Result.Dynamic.Y = AdjustedPosition.Y / Handle.ScreenRatio.Y;
				Result.Relative.X = (AdjustedPosition.X - (Handle.HUD.SizeX - NoBorderSizeX) / 2.f) / NoBorderSizeX;
				Result.Relative.Y = AdjustedPosition.Y / Handle.HUD.SizeY;
				Result.Offset.X = AdjustedPosition.X - (Handle.HUD.SizeX - NoBorderSizeX) / 2.f;
				Result.Offset.Y = AdjustedPosition.Y;
				break;
			case DM_Relative:
				Result.Dynamic.X = AdjustedPosition.X;
				Result.Dynamic.Y = AdjustedPosition.Y;
				Result.Relative.X = AdjustedPosition.X / Handle.HUD.SizeX;
				Result.Relative.Y = AdjustedPosition.Y / Handle.HUD.SizeY;
				Result.Offset.X = AdjustedPosition.X;
				Result.Offset.Y = AdjustedPosition.Y;
				break;
			default:
				break;
		}
	}

	return Result;
}

/**
 * MakeUVAbs
 * Declaration
 * Create a UV structure from independent values.
 * 
 * @param U Value for U.
 * @param V Value for V.
 * @param UL Value for UL.
 * @param VL Value for VL.
 * 
 * @return Structure.
 */
final static function KISUVAbsolute MakeUVAbs(int U, int V, int UL, int VL)
{
	local KISUVAbsolute UV;

	UV.U = U;
	UV.V = V;
	UV.UL = UL;
	UV.VL = VL;

	return UV;
}

/**
 * IsInRange
 * Declaration
 * Check if the value is between Min and Max.
 * 
 * @param V Value to check.
 * @param Min Minimal value.
 * @param Max Maximal value.
 * 
 * @return Return true if value is between (or same as) Min and Max.
 */
final static function bool IsInRange(float V, float Min, float Max)
{
	return V >= Min && V <= Max;
}

/**
 * GetMouseDifference
 * Declaration
 * Return offset from the mouse cursor in X and Y.
 * 
 * @param BaseValue 2D position to check.
 * @param Handle Reference to the handle where the mouse position is stored.
 * 
 * @return 2D XY distance from the mouse position.
 */
final static function IntPoint GetMouseDifference(IntPoint BaseValue, KISHandle Handle)
{
	local IntPoint Diff;

	if(Handle != none)
	{
		Diff.X = Handle.MousePosition.X - BaseValue.X;
		Diff.Y = Handle.MousePosition.Y - BaseValue.Y;
	}

	return Diff;
}

/**
 * DrawDebugText
 * Declaration
 * Draw a debug text on a position. The position is clamped on the size of the screen, so this text
 * will be always visible.
 * 
 * @param C Canvas used for the drawing.
 * @param X Position X.
 * @param Y Position Y.
 * @param S Text to draw.
 * @param DebugColor Color of text.
 */
final static function DrawDebugText(Canvas C, int X, int Y, coerce string S, Color DebugColor)
{
	local float XL, YL;
	local FontRenderInfo FRI;

	if(S != "")
	{
		C.Font = `DefaultDebugFont;
		C.SetDrawColorStruct(DebugColor);
		FRI = C.CreateFontRenderInfo(true);
		C.TextSize(S, XL, YL, 1.f, 1.f);
		if(X < 0)
		{
			X = 0;
		}
		else if(X + XL > C.SizeX)
		{
			X = C.SizeX - XL;
		}
		if(Y < 0)
		{
			Y = 0;
		}
		else if(Y + YL > C.SizeY)
		{
			Y = C.SizeY - YL;
		}
		C.SetPos(X, Y);
		C.DrawText(S,,1.f,1.f,FRI);
	}
}

/**
 * DrawDebugCross
 * Declaration
 * Draw a simple cross (+) which we use for a debugging.
 * 
 * @param C Canvas used for the drawing.
 * @param X Position X.
 * @param Y Position Y.
 * @param Size Size of cross in pixels.
 * @param DebugColor Color of text.
 */
final static function DrawDebugCross(Canvas C, int X, int Y, int Size, Color DebugColor)
{
	C.Draw2DLine(X - Size, Y, X + Size, Y, DebugColor);
	C.Draw2DLine(X, Y - Size, X, Y + Size, DebugColor);
}

/**
 * DrawDebugPosition
 * Declaration
 * Special function used to draw a debug graph of KISGUIPosition.
 * You can try this debug e.g. in a component.
 * 
 * @param C Canvas used for the drawing.
 * @param Start Position of this debug graph.
 * @param Pos Position to the debug.
 * @param DM Current Draw Mode.
 * @param Handle Reference to the handle.
 */
final static function DrawDebugPosition(Canvas C, IntPoint Start, KISGUIPosition Pos, EKISDrawMode DM, KISHandle Handle)
{
	local KISGUIPosition DynamicOnly;
	local IntPoint OutputDynamicOnly;
	local KISGUIPosition RelativeOnly;
	local IntPoint OutputRelativeOnly;
	local KISGUIPosition DynamicRelative;
	local IntPoint OutputDynamicRelative;
	local IntPoint OutputPos;

	DynamicOnly.Dynamic = Pos.Dynamic;
	RelativeOnly.Relative = Pos.Relative;
	DynamicRelative.Dynamic = Pos.Dynamic;
	DynamicRelative.Relative = Pos.Relative;

	OutputDynamicOnly = GetAdjustedPosition(DynamicOnly, DM, Handle);
	OutputRelativeOnly = GetAdjustedPosition(RelativeOnly, DM, Handle);
	OutputDynamicRelative = GetAdjustedPosition(DynamicRelative, DM, Handle);
	OutputPos = GetAdjustedPosition(Pos, DM, Handle);

	OutputDynamicOnly.X += Start.X;
	OutputDynamicOnly.Y += Start.Y;
	OutputRelativeOnly.X += Start.X;
	OutputRelativeOnly.Y += Start.Y;
	OutputDynamicRelative.X += Start.X;
	OutputDynamicRelative.Y += Start.Y;
	OutputPos.X += Start.X;
	OutputPos.Y += Start.Y;
	
	if(Pos.Dynamic.X != 0 || Pos.Dynamic.Y != 0)
	{
		C.Draw2DLine(Start.X, Start.Y, OutputDynamicOnly.X, OutputDynamicOnly.Y, MakeColor(255,0,0,255));
	}
	if(Pos.Relative.X != 0.f || Pos.Relative.Y != 0.f)
	{
		C.Draw2DLine(OutputDynamicOnly.X, OutputDynamicOnly.Y, OutputDynamicRelative.X, OutputDynamicRelative.Y, MakeColor(0,255,0,255));
	}
	if(Pos.Offset.X != 0 || Pos.Offset.Y != 0)
	{
		C.Draw2DLine(OutputDynamicRelative.X, OutputDynamicRelative.Y, OutputPos.X, OutputPos.Y, MakeColor(0,0,255,255));
	}

	if(Pos.Dynamic.X != 0 || Pos.Dynamic.Y != 0)
	{
		DrawDebugText(C, Start.X + (OutputDynamicOnly.X-Start.X) / 2, Start.Y + (OutputDynamicOnly.Y-Start.Y) / 2, "Dynamic:"@Pos.Dynamic.X$","@Pos.Dynamic.Y@"="@OutputDynamicOnly.X - Start.X$","@OutputDynamicOnly.Y - Start.Y, MakeColor(255,0,0,255));
	}

	if(Pos.Relative.X != 0.f || Pos.Relative.Y != 0.f)
	{
		DrawDebugText(C, OutputDynamicOnly.X + (OutputDynamicRelative.X-OutputDynamicOnly.X) / 2, OutputDynamicOnly.Y + (OutputDynamicRelative.Y-OutputDynamicOnly.Y) / 2, "Relative:"@Pos.Relative.X$","@Pos.Relative.Y@"="@OutputRelativeOnly.X - Start.X$","@OutputRelativeOnly.Y - Start.Y, MakeColor(0,255,0,255));
	}

	if(Pos.Offset.X != 0 || Pos.Offset.Y != 0)
	{
		DrawDebugText(C, OutputDynamicRelative.X + (OutputPos.X-OutputDynamicRelative.X) / 2, OutputDynamicRelative.Y + (OutputPos.Y-OutputDynamicRelative.Y) / 2, "Offset:"@Pos.Offset.X$","@Pos.Offset.Y@"="@Pos.Offset.X$","@Pos.Offset.Y, MakeColor(0,0,255,255));
	}	
}

/**
 * EaseValue
 * Declaration
 * Mathematical interpolations for different types of animations. We use this in Value Interpolator.
 * We utilize Robert Penner's easing equations http://www.robertpenner.com/easing/
 * For a visual example see http://easings.net/
 * If you want to reuse this function in your project,
 * please specify also source (Kiscan GUI Framework + Robert Penner's easing equations).
 * 
 * @param Func Type of the math function.
 * @param t Current time.
 * @param b Start value.
 * @param c Change in value.
 * @param d Duration.
 * @param s Optional adjustment of the ease curve. Use depends on the used function.
 * 
 * @return Current value.
 */
function float EaseValue(EKISEaseFunction Func, float t, float b, float c, float d, optional float s)
{
	local float Result;
	local float Alpha;
	local float p, a;

	t = Abs(t);
	d = Abs(d);
	s = Abs(s);
	
	a = c;
	Alpha = t / d;

	switch(Func)
	{
		case EF_Linear:
			Result = b + c * Alpha;
			break;
		case EF_InQuad:
			Result = b + c * Alpha * Alpha;
			break;
		case EF_OutQuad:
			Result = b + -c * Alpha * (Alpha - 2);
			break;
		case EF_InOutQuad:
			Alpha = t / (d / 2);
			if(Alpha < 1)
			{
				Result = b + c / 2 * Alpha * Alpha;
			}
			else
			{
			    Alpha -= 1;
                Result = b + -c / 2 * (Alpha * (Alpha - 2) - 1);
			}
			break;
		case EF_InCubic:
			Result = b + c * Alpha * Alpha * Alpha;
			break;
		case EF_OutCubic:
			Alpha = t / d - 1;
			Result = b + c * (Alpha * Alpha * Alpha + 1);
			break;
		case EF_InOutCubic:
			Alpha = t / (d / 2);
			if(Alpha < 1)
			{
				Result = b + c / 2 * Alpha * Alpha * Alpha;
			}
			else
			{
				Alpha -= 2;
				Result = b + c / 2 * (Alpha * Alpha * Alpha + 2);
			}
			break;
		case EF_InQuart:
			Result = b + c * Alpha * Alpha * Alpha * Alpha;
			break;
		case EF_OutQuart:
			Alpha = t / d - 1;
			Result = b + -c * (Alpha * Alpha * Alpha * Alpha - 1);
			break;
		case EF_InOutQuart:
			Alpha = t / (d / 2);
			if(Alpha < 1)
			{
				Result = b + c / 2 * Alpha * Alpha * Alpha * Alpha;
			}
			else
			{
				Alpha -= 2;
				Result = b + -c / 2 * (Alpha * Alpha * Alpha * Alpha - 2);
			}
			break;
		case EF_InQuint:
			Result = b + c * Alpha * Alpha * Alpha * Alpha * Alpha;
			break;
		case EF_OutQuint:
			Alpha = t / d - 1;
			Result = b + c * (Alpha * Alpha * Alpha * Alpha * Alpha + 1);
			break;
		case EF_InOutQuint:
			Alpha = t / (d / 2);
			if(Alpha < 1)
			{
				Result = b + c / 2 * Alpha * Alpha * Alpha * Alpha * Alpha;
			}
			else
			{
				Alpha -= 2;
				Result = b + c / 2 * (Alpha * Alpha * Alpha * Alpha * Alpha + 2);
			}
			break;
		case EF_InSine:
			Result = b + -c * Cos(Alpha * (PI / 2)) + c;
			break;
		case EF_OutSine:
			Result = b + c * Sin(Alpha * (PI / 2));
			break;
		case EF_InOutSine:
			Result = b + -c / 2 * (Cos(PI * Alpha) - 1);
			break;
		case EF_InExpo:
			Result = (t == 0) ? b : b + c * 2 ** (10 * (Alpha - 1));
			break;
		case EF_OutExpo:
			Result = (t == d) ? b + c : b + c * (-(2 ** (-10 * t/d)) + 1);
			break;
		case EF_InOutExpo:
			Alpha = t / (d / 2);
			if (t == 0)
			{
				Result = b;
			}
			else if(t == d)
			{
				Result = b + c;
			}
			else if(Alpha < 1)
			{
				return b + c / 2 * 2 ** (10 * (Alpha - 1));
			}
			else
			{
				Alpha -= 1;
				return b + c / 2 * (-(2 ** (-10 * Alpha)) + 2);
			}
			break;
		case EF_InCirc:
			Result = b + -c * (Sqrt(1 - Alpha * Alpha) - 1);
			break;
		case EF_OutCirc:
			Alpha = t / d - 1;
			Result = b + c * Sqrt(1 - Alpha * Alpha);
			break;
		case EF_InOutCirc:
			Alpha = t / (d / 2);
			if(Alpha < 1)
			{
				Result = b + -c / 2 * (Sqrt(1 - Alpha * Alpha) - 1);
			}
			else
			{
				Alpha -= 2;
				Result = b + c / 2 * (Sqrt(1 - Alpha * Alpha) + 1);
			}
			break;
		case EF_InElastic:
			s = 1.70158;
			if(t == 0)
			{
				Result = b; 
				break;
			}
			else if(Alpha == 1)
			{
				Result = b + c;
				break;
			}
			p = d * 0.3f;
			if (a < Abs(c))
			{
				s = p / 4;
			}
			else
			{
				s = p / (2 * PI) * Asin(c / a);
			}
			Alpha -= 1;
			Result = b + -(a * 2 ** (10 * Alpha) * Sin((Alpha * d - s) * (2 * PI) / p));
			break;
		case EF_OutElastic:
			s = 1.70158;
			if(t == 0)
			{
				Result = b;
				break;
			}
			else if(Alpha == 1)
			{
				Result = b + c; 
				break;
			}
			p = d * 0.3f;
			if(a < Abs(c))
			{
				s = p / 4;
			}
			else
			{
				s = p / (2 * PI) * Asin (c / a);
			}
			Result = b + a * 2 ** (-10 * Alpha) * Sin((Alpha * d - s) * (2 * PI) / p ) + c;
			break;
		case EF_InOutElastic:
			s = 1.70158;
			Alpha = t / (d / 2);
			if(t == 0)
			{
				Result = b;
				break;
			}
			else if(Alpha == 2)
			{
				Result = b + c;
				break;
			}
			p = d * (0.3f * 1.5f);
			if(a < Abs(c))
			{
				s = p / 4;
			}
			else
			{
				s = p / (2 * PI) * Asin(c / a);
			}
			if(Alpha < 1)
			{
				Alpha -= 1;
				Result = b + -0.5f * (a * (2 ** (10 * Alpha)) * Sin((Alpha * d - s) * (2 * PI) / p));
			}
			else
			{
				Alpha -= 1;
				Result = b + a * (2 ** (-10 * Alpha)) * Sin((Alpha * d - s) * (2 * PI) / p) * 0.5f + c;
			}
			break;
		case EF_InBack:
			if(s == 0.f)
			{
				s = 1.70158;
			}
			Result = b + c * Alpha * Alpha * ((s + 1) * Alpha - s);
			break;
		case EF_OutBack:
			if(s == 0.f)
			{
				s = 1.70158;
			}
			Alpha = t / d - 1;
			Result = b + c * (Alpha * Alpha * ((s + 1) * Alpha + s) + 1);
			break;
		case EF_InOutBack:
			if(s == 0.f)
			{
				s = 1.70158;
			}
			Alpha = t / (d / 2);
			if(Alpha < 1)
			{
				s *= 1.525;
				Result = b + c / 2 * (Alpha * Alpha * ((s + 1) * Alpha - s));
			}
			else
			{
				s *= 1.525;
				Alpha -= 2;
				Result = b + c / 2 * (Alpha * Alpha * ((s + 1) * Alpha + s) + 2);
			}
			break;
		case EF_InBounce:
			Result = b + c - EaseValue(EF_OutBounce, d - t, 0, c, d);
			break;
		case EF_OutBounce:
			if(Alpha < (1 / 2.75f))
			{
				Result = b + c * (7.5625 * Alpha * Alpha);
			}
			else if(Alpha < (2 / 2.75f))
			{
				Alpha -= 1.5f / 2.75f;
				Result = b + c * (7.5625f * Alpha * Alpha + 0.75f);
			}
			else if(Alpha < (2.5f / 2.75f))
			{
				Alpha -= 2.25f / 2.75f;
				Result = b + c * (7.5625f * Alpha * Alpha + 0.9375f);
			}
			else
			{
				Alpha -= 2.625f / 2.75f;
				Result = b + c * (7.5625f * Alpha * Alpha + 0.984375f);
			}
			break;
		case EF_InOutBounce:
			if(t < d / 2)
			{
				Result = b + EaseValue(EF_InBounce, t * 2, 0, c, d) * 0.5f;
			}
			else
			{
				Result = b + EaseValue(EF_OutBounce, t * 2 - d, 0, c, d) * 0.5f + c * 0.5f;
			}
			break;
		default:
			break;
	}

	return Result;
}