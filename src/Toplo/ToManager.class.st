Class {
	#name : #ToManager,
	#superclass : #Object,
	#instVars : [
		'world'
	],
	#classVars : [
		'UniqueInstance'
	],
	#classInstVars : [
		'session'
	],
	#category : #'Toplo-Core'
}

{ #category : #accessing }
ToManager class >> checkSession [

	session == Smalltalk session ifFalse: [ self reset ]
]

{ #category : #'class initialization' }
ToManager class >> initialize [

	SessionManager default registerGuiClassNamed: self name
]

{ #category : #'class initialization' }
ToManager class >> reset [
	<script>

	"self reset"

	"Session dependents"
	BlParallelUniverse initialize.
	session := -1.
	UniqueInstance := nil
]

{ #category : #'class initialization' }
ToManager class >> startUp: isResuming [

	isResuming ifTrue: [ self reset ]
]

{ #category : #accessing }
ToManager class >> uniqueInstance [

	self checkSession.
	^ UniqueInstance ifNil: [ UniqueInstance := self new ]
]

{ #category : #'world accessing' }
ToManager class >> world [

	^ self uniqueInstance world
]

{ #category : #'world accessing' }
ToManager >> world [ 

	| host |
	host := BlHost pickHost.
	world := host oblWorld.
	world when: BlSpaceDestroyedEvent do: [ world := nil ].
	^ world
]
