/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqEvent_LinkedTag extends KISSequenceEvent
	abstract;

var(Linked_Tag) array<string> Tag;

function bool CheckTag(name ReqTag)
{
	local string FoundTag;
	local bool bResult;

	PublishLinkedVariableValues();

	foreach Tag(FoundTag)
	{
		if(name(FoundTag) == ReqTag)
		{
			bResult = true;
			break;
		}
	}

	return bResult;
}

defaultproperties
{
	VariableLinks.Empty
	VariableLinks(0)=(ExpectedType=class'SeqVar_String',LinkDesc="Tags",PropertyName=Tag)
}