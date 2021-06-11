/**
 * Kiscan GUI Framework
 * 
 * KISCanvasObjectSpecial_SimpleText
 * 
 * COSpecial - Simple Text.
 * For more info see KISCanvasObjectSpecial.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISCanvasObjectSpecial_SimpleText extends KISCanvasObjectSpecial;

/** Canvas Object Archetype - Simple Text. */
var(List) const instanced KISNewCanvasObject_SimpleText DefaultCanvasObject;

/**
 * Init
 * Override
 */
function Init(KISHUD NewHUD, KISHandle NewHandle, KISModule NewModule, KISScene NewParentScene, KISComponent NewParentComponent)
{
	super.Init(NewHUD, NewHandle, NewModule, NewParentScene, NewParentComponent);

	CreateCanvasObject(DefaultCanvasObject.Tag,, DefaultCanvasObject.CanvasObject);
}
