/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqEvent_Comp_MouseHover extends KISSeqEvent_LinkedTag;

defaultproperties
{
	ObjName="Comp > Mouse Hover"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=Tag)
	OutputLinks(0)=(LinkDesc="Start")
	OutputLinks(1)=(LinkDesc="End")
}