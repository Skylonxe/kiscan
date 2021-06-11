/**
 * Kiscan GUI Framework
 * 
 * Copyright 2014 Ondrej Hrušovský, All Rights Reserved.
 */
class KISSeqAct_Utilities_ValueInterpolator extends KISSeqAct_Latent;

var(Value_Interpolator) float Duration<ClampMin=0.0>;
var(Value_Interpolator) EKISEaseFunction EaseFunction;
var(Value_Interpolator) bool bEndValueIsChangeInValue;
var(Value_Interpolator) EKISVariableType VariableType;

var(Value_Interpolator_Float) float StartValue;
var(Value_Interpolator_Float) float EndValue;

var(Value_Interpolator_Int) int StartValueInt;
var(Value_Interpolator_Int) int EndValueInt;

var(Value_Interpolator_Output) editconst float CurrentValue;
var(Value_Interpolator_Output) editconst int CurrentValueInt;
var(Value_Interpolator_Output) editconst float CurrentTime;

var bool bIsActive;
var bool bActivateOutputOne;
var KISValueInterpolator ValueInterpolator;

event Activated()
{
	local float SV, EV;
	local bool bCanActivate;

	super.Activated();

	if(ValueInterpolator == none)
	{
		ValueInterpolator = new class'KISValueInterpolator';
		ValueInterpolator.UpdateCurrentValue = UpdateCurrentValue;
		ValueInterpolator.UpdateCurrentTime = UpdateCurrentTime;
		ValueInterpolator.NotifyFinished = NotifyFinished;
	}

	if(InputLinks[0].bHasImpulse)
	{
		if(ValueInterpolator.bPaused)
		{
			bCanActivate = ValueInterpolator.Unpause();	
		}
		else
		{
			if(VariableType == VT_Float)
			{
				SV = StartValue;
				EV = EndValue;
			}
			else
			{
				SV = StartValueInt;
				EV = EndValueInt;
			}
			if(bEndValueIsChangeInValue)
			{
				bCanActivate = ValueInterpolator.Start(SV, EV, Abs(Duration), EaseFunction);
			}
			else
			{
				bCanActivate = ValueInterpolator.Start(SV, EV - SV, Abs(Duration), EaseFunction);
			}
		}

		bIsActive = bCanActivate;

		ActivateOutputLink(2);
		InputLinks[0].bHasImpulse = false;
	}
	else if(InputLinks[1].bHasImpulse)
	{
		ValueInterpolator.Stop();

		ActivateOutputLink(1);
		bActivateOutputOne = true;
		bIsActive = false;
		InputLinks[1].bHasImpulse = false;
	}
	else if(InputLinks[2].bHasImpulse)
	{
		ValueInterpolator.Pause();

		ActivateOutputLink(3);
		bIsActive = false;
		InputLinks[2].bHasImpulse = false;
	}
}

event Deactivated()
{
	super.Deactivated();

	if(!bActivateOutputOne)
	{
		OutputLinks[1].bHasImpulse = false; 
	}
	else
	{
		bActivateOutputOne = false;
	}
}

event bool Update(float DeltaTime)
{
	local float SV, EV;
	local bool bCanActivate;

	super.Update(DeltaTime);

	if(ValueInterpolator != none)
	{
		ValueInterpolator.Tick(DeltaTime);

		if(InputLinks[0].bHasImpulse)
		{
			if(ValueInterpolator.bPaused)
			{
				bCanActivate = ValueInterpolator.Unpause();	
			}
			else
			{
				if(VariableType == VT_Float)
				{
					SV = StartValue;
					EV = EndValue;
				}
				else
				{
					SV = StartValueInt;
					EV = EndValueInt;
				}
				if(bEndValueIsChangeInValue)
				{
					bCanActivate = ValueInterpolator.Start(SV, EV, Abs(Duration), EaseFunction);
				}
				else
				{
					bCanActivate = ValueInterpolator.Start(SV, EV - SV, Abs(Duration), EaseFunction);
				}
			}

			bIsActive = bCanActivate;	

			ActivateOutputLink(2);
			InputLinks[0].bHasImpulse = false;
		}
		else if(InputLinks[1].bHasImpulse)
		{
			ValueInterpolator.Stop();

			ActivateOutputLink(1);
			bActivateOutputOne = true;
			bIsActive = false;
			InputLinks[1].bHasImpulse = false;
		}
		else if(InputLinks[2].bHasImpulse)
		{
			ValueInterpolator.Pause();

			ActivateOutputLink(3);
			bIsActive = false;
			InputLinks[2].bHasImpulse = false;
		}
	}

	return bIsActive;
}

function UpdateCurrentValue(float V)
{
	CurrentValue = V;
	CurrentValueInt = FFloor(V);
	PopulateLinkedVariableValues();
	ActivateOutputLink(4);
}

function UpdateCurrentTime(float V)
{
	CurrentTime = V;
	PopulateLinkedVariableValues();
}

function NotifyFinished()
{
	bIsActive = false;
	ActivateOutputLink(0);
}

defaultproperties
{
	ObjName="Utilities > Value Interpolator"

	bAutoActivateOutputLinks=false
	
	InputLinks.Empty
	InputLinks(0)=(LinkDesc="Start")
	InputLinks(1)=(LinkDesc="Stop")
	InputLinks(2)=(LinkDesc="Pause")

	OutputLinks.Empty
	OutputLinks(0)=(LinkDesc="Finished")
	OutputLinks(1)=(LinkDesc="Aborted")
	OutputLinks(2)=(LinkDesc="Started")
	OutputLinks(3)=(LinkDesc="Paused")
	OutputLinks(4)=(LinkDesc="Value Updated")

	VariableLinks(0)=(ExpectedType=class'SeqVar_Float',LinkDesc="Start Value",PropertyName=StartValue)
	VariableLinks(1)=(ExpectedType=class'SeqVar_Int',LinkDesc="Start Value Int",PropertyName=StartValueInt)
	VariableLinks(2)=(ExpectedType=class'SeqVar_Float',LinkDesc="End Value",PropertyName=EndValue)
	VariableLinks(3)=(ExpectedType=class'SeqVar_Int',LinkDesc="End Value Int",PropertyName=EndValueInt)
	VariableLinks(4)=(ExpectedType=class'SeqVar_Float',LinkDesc="Duration",PropertyName=Duration,bHidden=true)
	VariableLinks(5)=(ExpectedType=class'SeqVar_Float',LinkDesc="Current Value",PropertyName=CurrentValue,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(6)=(ExpectedType=class'SeqVar_Int',LinkDesc="Current Value Int",PropertyName=CurrentValueInt,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true)
	VariableLinks(7)=(ExpectedType=class'SeqVar_Float',LinkDesc="Duration",PropertyName=Duration)
	VariableLinks(8)=(ExpectedType=class'SeqVar_Float',LinkDesc="Current Time",PropertyName=CurrentTime,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
	VariableLinks(9)=(ExpectedType=class'SeqVar_Bool',LinkDesc="Active",PropertyName=bActive,bWriteable=true,bSequenceNeverReadsOnlyWritesToThisVar=true,bHidden=true)
}