/**
 * Kiscan GUI Framework
 * 
 * KISCanvasObjectSpecial_All
 * 
 * COSpecial - All
 * For more info see KISCanvasObjectSpecial.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISCanvasObjectSpecial_All extends KISCanvasObjectSpecial;

/** Canvas Object Archetype. */
var(List) const instanced KISNewCanvasObject DefaultCanvasObject;

/**
 * Init
 * Override
 */
function Init(KISHUD NewHUD, KISHandle NewHandle, KISModule NewModule, KISScene NewParentScene, KISComponent NewParentComponent)
{
	super.Init(NewHUD, NewHandle, NewModule, NewParentScene, NewParentComponent);

	CreateCanvasObject(DefaultCanvasObject.Tag,, DefaultCanvasObject.CanvasObject);
}

