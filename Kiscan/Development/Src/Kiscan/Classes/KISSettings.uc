/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSettings extends KISObject;

/** Debug property. Draws cross on the position of the mouse cursor. */
var(Debug) bool bDrawDebugCursor;
/** Debug property. Color of the debug cursor. */
var(Debug) Color DebugCursorColor<EditCondition=bDrawDebugCursor>;

/** Resolution of a developer. */
var(Screen) IntPoint NativeResolution;

var(Console) bool bOverwriteConsoleBinding;
var(Console) name ConsoleKey<EditCondition=bOverwriteConsoleBinding>;
var(Console) name SmallConsoleKey<EditCondition=bOverwriteConsoleBinding>;

defaultproperties
{
	DebugCursorColor=(R=255,G=0,B=0,A=255)
	NativeResolution=(X=1920,Y=1080)

	ConsoleKey=Tab
	SmallConsoleKey=Tilde
}