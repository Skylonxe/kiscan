/**
 * Kiscan GUI Framework
 * 
 * KISHUD
 * 
 * HUD class draws overlays (e.g. Score, Health) on the player's screen. It utilizes the Canvas class for the drawing.
 * See more at UDN.
 * This class is where the hierarchy tree of Kiscan starts. Main class of Kiscan - KISHandle is created here.
 * 
 * Responsibilities of this class:
 * 
 * - Create new KISHandle or destroy existing one.
 * - Call appropriate functions in KISHandle.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISHUD extends `{KiscanHUDClass};

/** True after the first frame. If false then KISSeqEvent_Main_HUDInitialized has not happened yet. */
var bool bInitialized;

/** Reference to the main class of Kiscan - KISHandle. */
var KISHandle Handle;

/**
 * PostRender
 * Override
 * The start of the rendering chain. This function is where the drawing happens. The Canvas class
 * exists only during the PostRender.
 * It is called every frame.
 * super.PostRender() also calls the DrawHUD() function which is the primary function for drawing.
 * It makes turning off the drawing easier because we can simply stop calling DrawHUD().
 */
event PostRender()
{
	super.PostRender();

	if(!bInitialized)
	{
		bInitialized = true;
		TriggerGlobalEventClass(class'KISSeqEvent_Main_HUDInitialized', self);
	}
}

/**
 * Destroyed
 * Override
 * Called when HUD is being destroyed. It usually means that the game/level is closing.
 */
event Destroyed()
{
	super.Destroyed();

	if(Handle != none)
	{
		// Pass call to Handle and clean reference to our class
		// It needs to be destroyed manually because Kiscan classes are extended from Object class
		Handle.Destroy();
		Handle = none;
	}
}

/**
 * InitKiscan
 * Declaration
 * Creates new KISHandle. Called from the kismet action Init Kiscan.
 * 
 * @param NewSettings Initial settings of GUI. These are set inside the kismet action.
 */
function InitKiscan(KISSettings NewSettings)
{
	if(NewSettings != none)
	{
		if(Handle != none)
		{
			// Destroy the existing Handle if some exists
			Handle.Destroy();
		}

		Handle = new class'KISHandle';
		Handle.Init(self, NewSettings);
	}
}

/**
 * PreCalcValues
 * Override
 * Called when a resolution changes.
 */
function PreCalcValues()
{
	super.PreCalcValues();
	
	if(Handle != none)
	{
		Handle.NotifyResChange();
		TriggerGlobalEventClass(class'KISSeqEvent_Viewport_GameResolutionUpdated', self);
	}
}

/**
 * DrawHUD
 * Override
 * The main function where the our drawing happens. Called from the PostRender().
 */
function DrawHUD()
{
	local Vector2D MousePosition;

	super.DrawHUD();

	if(Handle != none)
	{
		// We also want to pass the current mouse position to the Handle
		MousePosition = GetMousePosition();
		TriggerGlobalEventClass(class'KISSeqEvent_Main_UpdateHUD', self);
		Handle.Render(Canvas, RenderDelta, MousePosition);
	}
}

/**
 * GetMousePosition
 * Declaration
 * Returns the current mouse position in 2D space (X,Y).
 * 
 * @return Current position of mouse cursor.
 */
function Vector2D GetMousePosition()
{
	local Vector2D MP;

	if(PlayerOwner != none && PlayerOwner.Player != none && LocalPlayer(PlayerOwner.Player) != none && LocalPlayer(PlayerOwner.Player).ViewportClient != none)
	{
		MP = LocalPlayer(PlayerOwner.Player).ViewportClient.GetMousePosition();
	}
	
	return MP;
}

/**
 * TriggerGlobalTagEvent
 * Declaration
 * Triggers any instance of the InEventClass node in the kismet which contains same Tag as ReqTag.
 * See more in the KISSeqEvent_LinkedTag class. Optionally we can specify an index of the output.
 * Works similar to the TriggerGlobalEventClass() function.
 * 
 * @param InEventClass Class of the event.
 * @param ReqTag Tag to look for.
 * @param ActivateIndex Index to activate. Default is -1.
 *  
 * @return True if successfully trigerred.
 */
simulated function bool TriggerGlobalTagEvent(class<KISSeqEvent_LinkedTag> InEventClass, name ReqTag, optional int ActivateIndex = INDEX_NONE)
{
	local array<SequenceObject> EventsToActivate;
	local array<int> ActivateIndices;
	local Sequence GameSeq;
	local bool bResult;
	local int i;

	if(ActivateIndex >= 0)
	{
		ActivateIndices[0] = ActivateIndex;
	}

	GameSeq = WorldInfo.GetGameSequence();
	if(GameSeq != None)
	{
		GameSeq.FindSeqObjectsByClass(InEventClass, true, EventsToActivate);
		for(i=0;i<EventsToActivate.Length;i++)
		{
			if(KISSeqEvent_LinkedTag(EventsToActivate[i]) != none && KISSeqEvent_LinkedTag(EventsToActivate[i]).CheckTag(ReqTag) && SequenceEvent(EventsToActivate[i]).CheckActivate(self, self,, ActivateIndices))
			{
				bResult = true;
			}
		}
	}

	return bResult;
}