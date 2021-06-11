/**
 * Kiscan GUI Framework
 * 
 * KISInfo
 * 
 * KISInfo is an abstract class used on the top of the framework.
 * It groups structures and enums and all almost all KIS classes depend on this class.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISInfo extends Object
	abstract;

enum EKISDrawMode
{
	DM_NoScale<DisplayName="No Scale">,
	DM_ExactFit<DisplayName="Exact Fit">,
	DM_ShowAll<DisplayName="Show All">,
	DM_NoBorder<DisplayName="No Border">,
	DM_Relative<DisplayName="Relative">,
};

enum EKISComponentShape
{
	CS_Box<DisplayName="Box">,
	CS_CircleOrEllipse<DisplayName="Circle or Ellipse">,
};

enum EKISTextureMode
{
	TM_Normal<DisplayName="Normal">,
	TM_Rotated<DisplayName="Rotated">,
	TM_Stretched<DisplayName="Stretched">,
};

enum EKISImageType
{
	IT_Material<DisplayName="Material">,
	IT_Texture<DisplayName="Texture">,
};

enum EKISButtonState
{
	BS_Idle,
	BS_Hover,
	BS_Clicked,
};

enum EKISMouseButton
{
	MB_Left<DisplayName="Left">,
	MB_Middle<DisplayName="Middle">,
	MB_Right<DisplayName="Right">,
	MB_ScrollUp<DisplayName="Scroll Up">,
	MB_ScrollDown<DisplayName="Scroll Down">,
};

enum EKISTextAlign
{
	TA_Left<DisplayName="Left">,
	TA_Center<DisplayName="Center">,
	TA_Right<DisplayName="Right">,
};

enum EKISEaseFunction
{
	EF_Linear<DisplayName="Linear">,
	EF_InQuad<DisplayName="In Quad">,
	EF_OutQuad<DisplayName="Out Quad">,
	EF_InOutQuad<DisplayName="In Out Quad">,
	EF_InCubic<DisplayName="In Cubic">,
	EF_OutCubic<DisplayName="Out Cubic">,
	EF_InOutCubic<DisplayName="In Out Cubic">,
	EF_InQuart<DisplayName="In Quart">,
	EF_OutQuart<DisplayName="Out Quart">,
	EF_InOutQuart<DisplayName="In Out Quart">,
	EF_InQuint<DisplayName="In Quint">,
	EF_OutQuint<DisplayName="Out Quint">,
	EF_InOutQuint<DisplayName="In Out Quint">,
	EF_InSine<DisplayName="In Sine">,
	EF_OutSine<DisplayName="Out Sine">,
	EF_InOutSine<DisplayName="In Out Sine">,
	EF_InExpo<DisplayName="In Expo">,
	EF_OutExpo<DisplayName="Out Expo">,
	EF_InOutExpo<DisplayName="In Out Expo">,
	EF_InCirc<DisplayName="In Circ">,
	EF_OutCirc<DisplayName="Out Circ">,
	EF_InOutCirc<DisplayName="In Out Circ">,
	EF_InElastic<DisplayName="In Elastic">,
	EF_OutElastic<DisplayName="Out Elastic">,
	EF_InOutElastic<DisplayName="In Out Elastic">,
	EF_InBack<DisplayName="In Back">,
	EF_OutBack<DisplayName="Out Back">,
	EF_InOutBack<DisplayName="In Out Back">,
	EF_InBounce<DisplayName="In Bounce">,
	EF_OutBounce<DisplayName="Out Bounce">,
	EF_InOutBounce<DisplayName="In Out Bounce">,
};

enum EKISVariableType
{
	VT_Float<DisplayName="Float">,
	VT_Int<DisplayName="Int">,
};

struct KISVector2DNorm
{
	var() float X<ClampMin=0.0|ClampMax=1.0>;
	var() float Y<ClampMin=0.0|ClampMax=1.0>;
};

struct KISVector2DUnsigned
{
	var() float X<ClampMin=0.0>;
	var() float Y<ClampMin=0.0>;
};

struct KISGUIPosition
{
	var() IntPoint Dynamic;
	var() Vector2D Relative;
	var() IntPoint Offset; 
};

struct KISUVNormalized
{
	var() float U;
	var() float V;
	var() float UL;
	var() float VL;
};

struct KISUVAbsolute 
{
	var() int U;
	var() int V;
	var() int UL;
	var() int VL;
};

struct KISNewCanvasObject
{
	var() const instanced KISCanvasObject CanvasObject;
	var() const name Tag;
};

struct KISNewCanvasObject_SimpleText
{
	var() const instanced KISCanvasObject_SimpleText CanvasObject;
	var() const name Tag;
};


struct KISNewComponent
{
	var() const KISComponent Component;
	var() const name Tag;
};

struct KISNewScene
{
	var() const KISScene Scene;
	var() const name Tag;
};

static final function int GetEnumCount_EKISDrawMode()
{
	return EKISDrawMode.EnumCount;
}

static final function int GetEnumCount_EKISComponentShape()
{
	return EKISComponentShape.EnumCount;
}

static final function int GetEnumCount_EKISTextureMode()
{
	return EKISTextureMode.EnumCount;
}

static final function int GetEnumCount_EKISImageType()
{
	return EKISImageType.EnumCount;
}

static final function int GetEnumCount_EKISButtonState()
{
	return EKISButtonState.EnumCount;
}

static final function int GetEnumCount_EKISMouseButton()
{
	return EKISMouseButton.EnumCount;
}

static final function int GetEnumCount_EKISTextAlign()
{
	return EKISTextAlign.EnumCount;
}

static final function int GetEnumCount_EKISEaseFunction()
{
	return EKISEaseFunction.EnumCount;
}

static final function int GetEnumCount_EKISVariableType()
{
	return EKISVariableType.EnumCount;
}
