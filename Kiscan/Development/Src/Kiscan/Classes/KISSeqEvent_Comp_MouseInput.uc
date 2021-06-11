/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqEvent_Comp_MouseInput extends KISSeqEvent_LinkedTag;

defaultproperties
{
	ObjName="Comp > Mouse Input"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=Tag)
	OutputLinks(0)=(LinkDesc="Left Pressed")
	OutputLinks(1)=(LinkDesc="Left Released")
	OutputLinks(2)=(LinkDesc="Right Pressed")
	OutputLinks(3)=(LinkDesc="Right Released")
	OutputLinks(4)=(LinkDesc="Middle Pressed")
	OutputLinks(5)=(LinkDesc="Middle Released")
	OutputLinks(6)=(LinkDesc="Scroll Up")
	OutputLinks(7)=(LinkDesc="Scroll Down")
}