/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Utilities_LaunchURL extends KISSequenceAction;

var(Target) string URL;

event Activated()
{
	super.Activated();

	class'Engine'.static.LaunchURL(URL);
}
	
defaultproperties
{
	ObjName="Utilities > Launch URL"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="URL",PropertyName=URL)
}