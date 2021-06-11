/**
 * Kiscan GUI Framework
 * 
 * KISValueInterpolator
 * 
 * Value Interpolate is the object which can be linked to any class and then perform smooth animations/interpolations of variables.
 * To implement Value Interpolator you need to call Tick() every frame from an owner class.
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISValueInterpolator extends KISObject;

/** Starting value. */
var privatewrite float StartValue;
/** StartValue + ChangeInValue = End Value */
var privatewrite float ChangeInValue;
/** Duration of an interpolation. */
var privatewrite float Duration;
/** Math function. */
var privatewrite EKISEaseFunction EaseFunc;

/** Current value of an animated variable. */
var privatewrite float CurrentValue;
/** Current time of an interpolation. */
var privatewrite float CurrentTime;

/** True if an interpolation is in progress. */
var privatewrite bool bPlaying;
/** True if an interpolation is paused. */
var privatewrite bool bPaused;

/** 
 *  NotifyFinished
 *  Declaration
 *  Called when an interpolation is finished.
 */
delegate NotifyFinished();

/**
 * UpdateCurrentValue
 * Declaration
 * Called every frame.
 * 
 * @param V Current Value of the interpolated variable.
 */
delegate UpdateCurrentValue(float V);

/**
 * UpdateCurrentTime
 * Declaration
 * Called very frame.
 * 
 * @param V Current time of an interpolation.
 */
delegate UpdateCurrentTime(float V);

/**
 * Start
 * Declaration
 * Starts an interplation.
 * 
 * @param NewStartValue
 * @param NewChangeInValue
 * @param NewDuration
 * @param NewEaseFunc
 * 
 * @return True if started successfuly.
 */
function bool Start(float NewStartValue, float NewChangeInValue, float NewDuration, EKISEaseFunction NewEaseFunc)
{
	local bool bCanStart;

	if(NewChangeInValue != 0.f && NewDuration != 0.f)
	{
		StartValue = NewStartValue;
		ChangeInValue = NewChangeInValue;
		Duration = Abs(NewDuration);
		EaseFunc = NewEaseFunc;

		bPlaying = true;
		bPaused = false;
		CurrentTime = 0.f;

		bCanStart = true;
	}

	return bCanStart;
}

/**
 * Stop
 * Declaration
 * Stops current interpolation.
 * 
 * @return True if we stopped successfuly.
 */
function bool Stop()
{
	local bool bCanStop;

	if(bPlaying)
	{
		bPlaying = false;
		CurrentTime = 0.f;

		UpdateCurrentValue(StartValue);
		UpdateCurrentTime(CurrentTime);

		bCanStop = true;
	}

	return bCanStop;
}

/**
 * Tick
 * Declaration
 * Call this every frame from the owner.
 * This function performs an interpolation.
 * 
 * @param DeltaTime Current DT.
 */
function Tick(float DeltaTime)
{
	if(bPlaying)
	{
		CurrentTime = FMin(CurrentTime + DeltaTime, Duration);
		CurrentValue = EaseValue(EaseFunc, CurrentTime, StartValue, ChangeInValue, Duration);

		UpdateCurrentValue(CurrentValue);
		UpdateCurrentTime(CurrentTime);

		if(CurrentTime == Duration)
		{
			bPlaying = false;
			NotifyFinished();
		}
	}
}

/**
 * Pause
 * Declaration
 * Pauses an interpolation.
 * 
 * @return True if successfully paused.
 */
function bool Pause()
{
	local bool bCanPause;

	if(!bPaused)
	{
		bPlaying = false;
		bPaused = true;

		bCanPause = true;
	}

	return bCanPause;
}

/**
 * Unpause
 * Declaration
 * Unpauses an interpolation.
 * 
 * @return True if successfully unpaused.
 */
function bool Unpause()
{
	local bool bCanUnpause;

	if(bPaused)
	{
		bPaused = false;
		bPlaying = true;

		bCanUnpause = true;
	}

	return bCanUnpause;
}
