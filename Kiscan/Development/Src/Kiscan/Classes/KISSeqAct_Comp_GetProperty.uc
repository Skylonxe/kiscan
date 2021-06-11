/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_GetProperty extends KISSequenceAction;

var(Target) string ComponentTag;

var(Basic_Appearance) editconst int PositionDynamicX;
var(Basic_Appearance) editconst int PositionDynamicY;
var(Basic_Appearance) editconst float PositionRelativeX;
var(Basic_Appearance) editconst float PositionRelativeY;
var(Basic_Appearance) editconst int PositionOffsetX;
var(Basic_Appearance) editconst int PositionOffsetY;

var(Cursor) editconst bool bAttachToCursor;
var(Cursor) editconst int AttachToCursorOffsetDynamicX;
var(Cursor) editconst int AttachToCursorOffsetDynamicY;
var(Cursor) editconst float AttachToCursorOffsetRelativeX;
var(Cursor) editconst float AttachToCursorOffsetRelativeY;
var(Cursor) editconst int AttachToCursorOffsetOffsetX;
var(Cursor) editconst int AttachToCursorOffsetOffsetY;

var(Kismet) editconst bool bTriggerKismetEvent_MouseHover;
var(Kismet) editconst bool bTriggerKismetEvent_MouseInput;

var(Rendering) editconst bool bEnabled;
var(Rendering) editconst int Priority;

var(Other) editconst bool bMouseHover;
var(Other) editconst int LeftClickDiffX;
var(Other) editconst int LeftClickDiffY;
var(Other) editconst int RightClickDiffX;
var(Other) editconst int RightClickDiffY;
var(Other) editconst int MiddleClickDiffX;
var(Other) editconst int MiddleClickDiffY;

event Activated()
{
	local KISComponent Comp;

	super.Activated();

	Comp = GetComponentByTag(name(ComponentTag));
	UpdateProperties(Comp);
}

function UpdateProperties(KISComponent Comp)
{
	if(Comp != none)
	{
		class'KISObject'.static.GetIndividualGUIPos(Comp.Position, PositionDynamicX, PositionDynamicY, PositionRelativeX, PositionRelativeY, PositionOffsetX, PositionOffsetY);

		bAttachToCursor = Comp.bAttachToCursor;
		class'KISObject'.static.GetIndividualGUIPos(Comp.AttachToCursorOffset, AttachToCursorOffsetDynamicX, AttachToCursorOffsetDynamicY, AttachToCursorOffsetRelativeX, AttachToCursorOffsetRelativeY, AttachToCursorOffsetOffsetX, AttachToCursorOffsetOffsetY);

		bTriggerKismetEvent_MouseHover = Comp.bTriggerKismetEvent_MouseHover;
		bTriggerKismetEvent_MouseInput = Comp.bTriggerKismetEvent_MouseInput;

		bEnabled = Comp.bEnabled;
		Priority = Comp.Priority;

		bMouseHover = Comp.bMouseHover;
		LeftClickDiffX = Comp.LeftClickDiff.X;
		LeftClickDiffY = Comp.LeftClickDiff.Y;
		RightClickDiffX = Comp.RightClickDiff.X;
		RightClickDiffY = Comp.RightClickDiff.Y;
		MiddleClickDiffX = Comp.MiddleClickDiff.X;
		MiddleClickDiffY = Comp.MiddleClickDiff.Y;
	}
}

defaultproperties
{
	ObjName="Comp > Get Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Component",PropertyName=ComponentTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn X",PropertyName=PositionDynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn Y",PropertyName=PositionDynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel X",PropertyName=PositionRelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel Y",PropertyName=PositionRelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off X",PropertyName=PositionOffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off Y",PropertyName=PositionOffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(7)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Attach to Cursor",PropertyName=bAttachToCursor,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(8)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn X",PropertyName=AttachToCursorOffsetDynamicX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn Y",PropertyName=AttachToCursorOffsetDynamicY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel X",PropertyName=AttachToCursorOffsetRelativeX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel Y",PropertyName=AttachToCursorOffsetRelativeY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off X",PropertyName=AttachToCursorOffsetOffsetX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off Y",PropertyName=AttachToCursorOffsetOffsetY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(14)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Trigger Kismet Event - Mouse Hover",PropertyName=bTriggerKismetEvent_MouseHover,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Trigger Kismet Event - Mouse Input",PropertyName=bTriggerKismetEvent_MouseInput,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(16)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enabled",PropertyName=bEnabled,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Int',LinkDesc="Priority",PropertyName=Priority,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)

	VariableLinks(18)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Mouse Hover",PropertyName=bMouseHover,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(19)=(ExpectedType=class'SeqVar_Int',LinkDesc="Left Click Diff X",PropertyName=LeftClickDiffX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(20)=(ExpectedType=class'SeqVar_Int',LinkDesc="Left Click Diff Y",PropertyName=LeftClickDiffY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(21)=(ExpectedType=class'SeqVar_Int',LinkDesc="Right Click Diff X",PropertyName=RightClickDiffX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(22)=(ExpectedType=class'SeqVar_Int',LinkDesc="Right Click Diff Y",PropertyName=RightClickDiffY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(23)=(ExpectedType=class'SeqVar_Int',LinkDesc="Middle Click Diff X",PropertyName=MiddleClickDiffX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(24)=(ExpectedType=class'SeqVar_Int',LinkDesc="Middle Click Diff Y",PropertyName=MiddleClickDiffY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}
