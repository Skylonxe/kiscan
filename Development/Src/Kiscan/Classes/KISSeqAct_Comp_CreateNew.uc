/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Comp_CreateNew extends KISSequenceAction;

var(Target) string OwnerSceneTag;

var(Create_New) array<string> NewComponentTag;
var(Create_New) class<KISComponent> ComponentClass;
var(Create_New) KISComponent ComponentArchetype;

event Activated()
{
	local KISScene Sce;
	local string FoundTag;

	super.Activated();

	Sce = GetSceneByTag(name(OwnerSceneTag));

	if(Sce != none)
	{
		foreach NewComponentTag(FoundTag)
		{
			if(FoundTag != "")
			{
				Sce.CreateComponent(name(FoundTag), ComponentClass, ComponentArchetype);
			}
		}
	}
}

defaultproperties
{
	ObjName = "Comp > Create New"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Owner Scene",PropertyName=OwnerSceneTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="New Component Tags",PropertyName=NewComponentTag)
}