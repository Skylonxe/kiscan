/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Scene_CreateNew extends KISSequenceAction;

var(Target) string ParentSceneTag;

var(Create_New) array<string> NewSceneTag;
var(Create_New) class<KISScene> SceneClass;
var(Create_New) KISScene SceneArchetype;

event Activated()
{
	local KISScene ParentScene;
	local KISHUD CustomHUD;
	local string FoundTag;
	
	CustomHUD = GetHUD();

	if(CustomHUD != none && CustomHUD.Handle != none && CustomHUD.Handle.Module.Length > 0 && CustomHUD.Handle.Module[0] != none)
	{
		ParentScene = GetSceneByTag(name(ParentSceneTag));

		foreach NewSceneTag(FoundTag)
		{
			if(FoundTag != "")
			{
				if(ParentScene == none)
				{
					CustomHUD.Handle.Module[0].CreateScene(name(FoundTag), SceneClass, SceneArchetype);
				}
				else
				{
					ParentScene.CreateSubScene(name(FoundTag), SceneClass, SceneArchetype);
				}
			}
		}
	}
}

defaultproperties
{
	ObjName="Scene > Create New"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Parent Scene",PropertyName=ParentSceneTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_String',LinkDesc="New Scene Tags",PropertyName=NewSceneTag)
}