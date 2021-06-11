/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_GetOutputProperty extends KISSequenceAction;

var(Target) string ComponentTag;
var(Target) string CanvasObjectTag;

var(Output_Property) editconst int OutputPositionX;
var(Output_Property) editconst int OutputPositionY;
var(Output_Property) editconst float OutputSizeX;
var(Output_Property) editconst float OutputSizeY;
var(Output_Property) editconst int OutputShapePositionX;
var(Output_Property) editconst int OutputShapePositionY;
var(Output_Property) editconst float OutputShapeSizeX;
var(Output_Property) editconst float OutputShapeSizeY;
var(Output_Property) editconst int OutputMaskPositionX;
var(Output_Property) editconst int OutputMaskPositionY;
var(Output_Property) editconst float OutputMaskMaskSizeX;
var(Output_Property) editconst float OutputMaskMaskSizeY;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}

function UpdateProperties(KISComponent Comp)
{
	local KISCanvasObject CO;

	if(Comp != none)
	{
		CO = Comp.GetCOByTag(name(CanvasObjectTag));

		if(CO != none)
		{
			OutputPositionX = CO.OutputPosition.X;
			OutputPositionY = CO.OutputPosition.Y;
			OutputSizeX = CO.OutputSize.X;
			OutputSizeY = CO.OutputSize.Y;
			OutputShapePositionX = CO.OutputShapePosition.X;
			OutputShapePositionY = CO.OutputShapePosition.Y;
			OutputShapeSizeX = CO.OutputShapeSize.X;
			OutputShapeSizeY = CO.OutputShapeSize.Y;
			OutputMaskPositionX = CO.OutputMaskPosition.X;
			OutputMaskPositionY = CO.OutputMaskPosition.Y;
			OutputMaskMaskSizeX = CO.OutputMaskSize.X;
			OutputMaskMaskSizeY = CO.OutputMaskSize.Y;
		}
	}
}

defaultproperties
{
	ObjName="CO > Get Output Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Canvas Object",PropertyName=CanvasObjectTag,MaxVars=1)

	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Pos X",PropertyName=OutputPositionX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Pos Y",PropertyName=OutputPositionY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Out Size X",PropertyName=OutputSizeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Float',LinkDesc="Out Size Y",PropertyName=OutputSizeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Shape Pos X",PropertyName=OutputShapePositionX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Shape Pos Y",PropertyName=OutputShapePositionY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Float',LinkDesc="Out Shape Size X",PropertyName=OutputShapeSizeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Float',LinkDesc="Out Shape Size Y",PropertyName=OutputShapeSizeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Mask Pos X",PropertyName=OutputMaskPositionX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Mask Pos Y",PropertyName=OutputMaskPositionY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Float',LinkDesc="Out Mask Size X",PropertyName=OutputMaskMaskSizeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Float',LinkDesc="Out Mask Size Y",PropertyName=OutputMaskMaskSizeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
