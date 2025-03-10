Extension { #name : #OBlSpace }

{ #category : #'*Toplo-Tests' }
OBlSpace class >> pulseUntilEmptyTaskQueue: aSpace timeout: aDuration [
	"Wait until a BlSpace doesn't have available tasks to execute. 
	
	Inspired on BlDevScripterWaitStep>>#forEmptySpaceTaskQueueTimeout:"

	| deadline |
	deadline := aSpace time now + aDuration.
	
	aSpace time
		every: 5 milliSeconds
		while: [
			aSpace taskQueue traceCr.
			(aSpace taskQueue isEmpty or: [
				aSpace time now >= deadline ]) not ]
		do: [ aSpace pulse ].

	aSpace pulse.

	^ aSpace taskQueue isEmpty
]
