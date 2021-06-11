/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_SetProperty extends KISSequenceAction;

var(Target) array<string> ComponentTag;

var bool bUpdatePositionDynamicX;
var(Basic_Appearance) int PositionDynamicX<EditCondition=bUpdatePositionDynamicX>;
var bool bUpdatePositionDynamicY;
var(Basic_Appearance) int PositionDynamicY<EditCondition=bUpdatePositionDynamicY>;
var bool bUpdatePositionRelativeX;
var(Basic_Appearance) float PositionRelativeX<EditCondition=bUpdatePositionRelativeX>;
var bool bUpdatePositionRelativeY;
var(Basic_Appearance) float PositionRelativeY<EditCondition=bUpdatePositionRelativeY>;
var bool bUpdatePositionOffsetX;
var(Basic_Appearance) int PositionOffsetX<EditCondition=bUpdatePositionOffsetX>;
var bool bUpdatePositionOffsetY;
var(Basic_Appearance) int PositionOffsetY<EditCondition=bUpdatePositionOffsetY>;

var bool bUpdateAttachToCursor;
var(Cursor) bool bAttachToCursor<EditCondition=bUpdateAttachToCursor>;
var bool bUpdateAttachToCursorOffsetDynamicX;
var(Cursor) int AttachToCursorOffsetDynamicX<EditCondition=bUpdateAttachToCursorOffsetDynamicX>;
var bool bUpdateAttachToCursorOffsetDynamicY;
var(Cursor) int AttachToCursorOffsetDynamicY<EditCondition=bUpdateAttachToCursorOffsetDynamicY>;
var bool bUpdateAttachToCursorOffsetRelativeX;
var(Cursor) float AttachToCursorOffsetRelativeX<EditCondition=bUpdateAttachToCursorOffsetRelativeX>;
var bool bUpdateAttachToCursorOffsetRelativeY;
var(Cursor) float AttachToCursorOffsetRelativeY<EditCondition=bUpdateAttachToCursorOffsetRelativeY>;
var bool bUpdateAttachToCursorOffsetOffsetX;
var(Cursor) int AttachToCursorOffsetOffsetX<EditCondition=bUpdateAttachToCursorOffsetOffsetX>;
var bool bUpdateAttachToCursorOffsetOffsetY;
var(Cursor) int AttachToCursorOffsetOffsetY<EditCondition=bUpdateAttachToCursorOffsetOffsetY>;

var bool bUpdateTriggerKismetEvent_MouseHover;
var(Kismet) bool bTriggerKismetEvent_MouseHover<EditCondition=bUpdateTriggerKismetEvent_MouseHover>;
var bool bUpdateTriggerKismetEvent_MouseInput;
var(Kismet) bool bTriggerKismetEvent_MouseInput<EditCondition=bUpdateTriggerKismetEvent_MouseInput>;

var bool bUpdateEnabled;
var(Rendering) bool bEnabled<EditCondition=bUpdateEnabled>;
var bool bUpdatePriority;
var(Rendering) int Priority<EditCondition=bUpdatePriority>;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;

	super.Activated();

	foreach ComponentTag(FoundTag)
	{
		Comp = GetComponentByTag(name(FoundTag));
		UpdateProperties(Comp);
	}
}

function UpdateProperties(KISComponent Comp)
{
	if(Comp != none)
	{
		if(bUpdatePositionDynamicX)
		{
			Comp.Position.Dynamic.X = PositionDynamicX;
		}
		if(bUpdatePositionDynamicY)
		{
			Comp.Position.Dynamic.Y = PositionDynamicY;
		}
		if(bUpdatePositionRelativeX)
		{
			Comp.Position.Relative.X = PositionRelativeX;
		}
		if(bUpdatePositionRelativeY)
		{
			Comp.Position.Relative.Y = PositionRelativeY;
		}
		if(bUpdatePositionOffsetX)
		{
			Comp.Position.Offset.X = PositionOffsetX;
		}
		if(bUpdatePositionOffsetY)
		{
			Comp.Position.Offset.Y = PositionOffsetY;
		}
		if(bUpdateAttachToCursor)
		{
			Comp.bAttachToCursor = bAttachToCursor;
		}
		if(bUpdateAttachToCursorOffsetDynamicX)
		{
			Comp.AttachToCursorOffset.Dynamic.X = AttachToCursorOffsetDynamicX;
		}
		if(bUpdateAttachToCursorOffsetDynamicY)
		{
			Comp.AttachToCursorOffset.Dynamic.Y = AttachToCursorOffsetDynamicY;
		}
		if(bUpdateAttachToCursorOffsetRelativeX)
		{
			Comp.AttachToCursorOffset.Relative.X = AttachToCursorOffsetRelativeX;
		}
		if(bUpdateAttachToCursorOffsetRelativeY)
		{
			Comp.AttachToCursorOffset.Relative.Y = AttachToCursorOffsetRelativeY;
		}
		if(bUpdateAttachToCursorOffsetOffsetX)
		{
			Comp.AttachToCursorOffset.Offset.X = AttachToCursorOffsetOffsetX;
		}
		if(bUpdateAttachToCursorOffsetOffsetY)
		{
			Comp.AttachToCursorOffset.Offset.Y = AttachToCursorOffsetOffsetY;
		}
		if(bUpdateTriggerKismetEvent_MouseHover)
		{
			Comp.bTriggerKismetEvent_MouseHover = bTriggerKismetEvent_MouseHover;
		}
		if(bUpdateTriggerKismetEvent_MouseInput)
		{
			Comp.bTriggerKismetEvent_MouseInput = bTriggerKismetEvent_MouseInput;
		}
		if(bUpdateEnabled)
		{
			Comp.bEnabled = bEnabled;
		}
		if(bUpdatePriority)
		{
			Comp.SetPriority(Priority);
		}

		Comp.UpdateDynamicProperties();
	}
}

defaultproperties
{
	ObjName="Comp > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn X",PropertyName=PositionDynamicX,MaxVars=1,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Dyn Y",PropertyName=PositionDynamicY,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel X",PropertyName=PositionRelativeX,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Pos Rel Y",PropertyName=PositionRelativeY,MaxVars=1,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off X",PropertyName=PositionOffsetX,MaxVars=1,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Pos Off Y",PropertyName=PositionOffsetY,MaxVars=1,bHidden=true)

	VariableLinks(7)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Attach to Cursor",PropertyName=bAttachToCursor,MaxVars=1,bHidden=true)

	VariableLinks(8)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn X",PropertyName=AttachToCursorOffsetDynamicX,MaxVars=1,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Dyn Y",PropertyName=AttachToCursorOffsetDynamicY,MaxVars=1,bHidden=true)
	VariableLinks(10)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel X",PropertyName=AttachToCursorOffsetRelativeX,MaxVars=1,bHidden=true)
	VariableLinks(11)=(ExpectedType=class'SeqVar_Float',LinkDesc="Attach to Cursor Offset Rel Y",PropertyName=AttachToCursorOffsetRelativeY,MaxVars=1,bHidden=true)
	VariableLinks(12)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off X",PropertyName=AttachToCursorOffsetOffsetX,MaxVars=1,bHidden=true)
	VariableLinks(13)=(ExpectedType=class'SeqVar_Int',LinkDesc="Attach to Cursor Offset Off Y",PropertyName=AttachToCursorOffsetOffsetY,MaxVars=1,bHidden=true)

	VariableLinks(14)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Trigger Kismet Event - Mouse Hover",PropertyName=bTriggerKismetEvent_MouseHover,MaxVars=1,bHidden=true)
	VariableLinks(15)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Trigger Kismet Event - Mouse Input",PropertyName=bTriggerKismetEvent_MouseInput,MaxVars=1,bHidden=true)

	VariableLinks(16)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Enabled",PropertyName=bEnabled,MaxVars=1,bHidden=true)
	VariableLinks(17)=(ExpectedType=class'SeqVar_Int',LinkDesc="Priority",PropertyName=Priority,MaxVars=1,bHidden=true)
}