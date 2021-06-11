/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqEvent_Comp_Button_Checkbox_Checked extends KISSeqEvent_LinkedTag;

defaultproperties
{
	ObjName="Comp > Button > Checkbox > Checked"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=Tag)
	OutputLinks(0)=(LinkDesc="Checked")
	OutputLinks(1)=(LinkDesc="Unchecked")
}