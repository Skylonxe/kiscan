/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Scene_GetOutputProperty extends KISSequenceAction;

var(Target) string SceneTag;

var(Output_Property) editconst int OutputPositionX;
var(Output_Property) editconst int OutputPositionY;

event Activated()
{
	super.Activated();

	UpdateProperties(GetSceneByTag(name(SceneTag)));
}

function UpdateProperties(KISScene Sce)
{
	if(Sce != none)
	{
		OutputPositionX = Sce.OutputPosition.X;
		OutputPositionY = Sce.OutputPosition.Y;
	}
}

defaultproperties
{
	ObjName="Scene > Get Output Property"

	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Scene",PropertyName=SceneTag,MaxVars=1)

	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Position X",PropertyName=OutputPositionX,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Int',LinkDesc="Out Position Y",PropertyName=OutputPositionY,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}