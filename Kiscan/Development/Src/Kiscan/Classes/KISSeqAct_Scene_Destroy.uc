/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Scene_Destroy extends KISSequenceAction;

var(Destroy) array<string> SceneTag;

event Activated()
{
	local string FoundTag;
	local KISScene Sce;

	super.Activated();

	foreach SceneTag(FoundTag)
	{
		Sce = GetSceneByTag(name(FoundTag));

		if(Sce != none)
		{
			Sce.Destroy();
		}
	}
}
	
defaultproperties
{
	ObjName="Scene > Destroy"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Scenes",PropertyName=SceneTag)
}