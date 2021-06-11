/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_CO_CreateNew extends KISSequenceAction;

var(Target) string OwnerComponentTag;
var(Target) string OwnerCOListTag;

var(Create_New) array<string> NewCanvasObjectTag;
var(Create_New) class<KISCanvasObject> CanvasObjectClass;
var(Create_New) KISCanvasObject CanvasObjectArchetype;

event Activated()
{
	local string FoundCOTag;
	local KISComponent Comp;
	local KISCanvasObjectList COList;
	local KISCanvasObjectSpecial COSpecial;

	super.Activated();

	Comp = GetComponentByTag(name(OwnerComponentTag));
	
	if(Comp != none)
	{
		COList = Comp.GetCOListByTag(name(OwnerCOListTag));
		COSpecial = Comp.GetCOSpecialByTag(name(OwnerCOListTag));

		if(COList != none)
		{
			foreach NewCanvasObjectTag(FoundCOTag)
			{
				if(FoundCOTag != "")
				{
					COList.CreateCanvasObject(name(FoundCOTag), CanvasObjectClass, CanvasObjectArchetype);
				}
			}
		}
		else if(COSpecial != none && NewCanvasObjectTag.Length > 0)
		{
			if(NewCanvasObjectTag[0] != "")
			{
				COSpecial.CreateCanvasObject(name(NewCanvasObjectTag[0]), CanvasObjectClass, CanvasObjectArchetype);
			}
		}
	}
}

defaultproperties
{
	ObjName="CO > Create New"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Owner Component",PropertyName=OwnerComponentTag,MaxVars=1)
	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="Owner CO List",PropertyName=OwnerCOListTag,MaxVars=1)

	VariableLinks(2)=(ExpectedType=class'SeqVar_String',LinkDesc="New CO Tags",PropertyName=NewCanvasObjectTag)
}