/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_Button_SetProperty extends KISSequenceAction;

var(Target) array<string> ComponentTag;

var bool bUpdateDrawIdleUnderHover;
var(Button) bool bDrawIdleUnderHover<EditCondition=bUpdateDrawIdleUnderHover>;
var bool bUpdateDrawIdleUnderClicked;
var(Button) bool bDrawIdleUnderClicked<EditCondition=bUpdateDrawIdleUnderClicked>;
var bool bUpdateDrawHoverUnderClicked;
var(Button) bool bDrawHoverUnderClicked<EditCondition=bUpdateDrawHoverUnderClicked>;

var bool bUpdateActivateByMouseButton;
var(Button_Input) bool bActivateByMouseButton<EditCondition=bUpdateActivateByMouseButton>;
var bool bUpdateMouseButton;
var(Button_Input) EKISMouseButton MouseButton<EditCondition=bUpdateMouseButton>;
var int MouseButtonIdx;
var bool bUpdateKeyBind;
var(Button_Input) array<string> KeyBind<EditCondition=bUpdateKeyBind>;
var bool bUpdateUsePressInsteadRelease;
var(Button_Input) bool bUsePressInsteadRelease<EditCondition=bUpdateUsePressInsteadRelease>;

event Activated()
{
	local string FoundTag;
	local KISComponent Comp;

	super.Activated();

	foreach ComponentTag(FoundTag)
	{
		Comp = GetComponentByTag(name(FoundTag));

		if(Comp != none)
		{
			UpdateProperties(KISComponent_Button(Comp));
		}
	}
}

function UpdateProperties(KISComponent_Button Comp)
{
	local array<name> KeyBindName;
	local int i;

	if(Comp != none)
	{
		if(bUpdateDrawIdleUnderHover)
		{
			Comp.bDrawIdleUnderHover = bDrawIdleUnderHover;
		}
		if(bUpdateDrawIdleUnderClicked)
		{
			Comp.bDrawIdleUnderClicked = bDrawIdleUnderClicked;
		}
		if(bUpdateDrawHoverUnderClicked)
		{
			Comp.bDrawHoverUnderClicked = bDrawHoverUnderClicked;
		}
		if(bUpdateActivateByMouseButton)
		{
			Comp.bActivateByMouseButton = bActivateByMouseButton;
		}
		if(bUpdateMouseButton)
		{
			if(MouseButtonIdx != -1)
			{
				Comp.MouseButton = EKISMouseButton(Clamp(MouseButtonIdx, 0, class'KISInfo'.static.GetEnumCount_EKISMouseButton() - 1));
			}
			else
			{
				Comp.MouseButton = MouseButton;
			}
		}
		if(bUpdateKeyBind)
		{
			for(i=0;i<KeyBind.Length;i++)
			{
				if(KeyBind[i] != "")
				{
					KeyBindName.AddItem(name(KeyBind[i]));
				}
			}

			Comp.KeyBind = KeyBindName;
		}
		if(bUpdateUsePressInsteadRelease)
		{
			Comp.bUsePressInsteadRelease = bUsePressInsteadRelease;
		}

		Comp.UpdateDynamicProperties();
	}
}

defaultproperties
{
	ObjName="Comp > Button > Set Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Components",PropertyName=ComponentTag)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Idle Under Hover",PropertyName=bDrawIdleUnderHover,MaxVars=1,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Idle Under Clicked",PropertyName=bDrawIdleUnderClicked,MaxVars=1,bHidden=true)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Draw Hover Under Clicked",PropertyName=bDrawHoverUnderClicked,MaxVars=1,bHidden=true)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Activate By Mouse Button",PropertyName=bActivateByMouseButton,MaxVars=1,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Int',LinkDesc="Mouse Button",PropertyName=MouseButtonIdx,MaxVars=1,bHidden=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_String',LinkDesc="Key Bind",PropertyName=KeyBind,bHidden=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Use Press Instead Release",PropertyName=bUsePressInsteadRelease,MaxVars=1,bHidden=true)
}