"
I'm a workspace example made with Album/Toplo
"
Class {
	#name : #ToWorkspaceExample,
	#superclass : #Object,
	#instVars : [
		'textModel',
		'bindings'
	],
	#classVars : [
		'MyTranscript'
	],
	#category : #'Toplo-Examples'
}

{ #category : #'instance creation' }
ToWorkspaceExample class >> closeTranscript [

	MyTranscript ifNotNil: [ MyTranscript close ]
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInHost: aBlOSWindowHost [

	<script>
	| space |
	self transcriptAlreadyOpened ifFalse: [ self openTranscript ].

	space := aBlOSWindowHost oblWorld.
	space isOpened ifFalse: [ space show ].
	self new openInSpace: space
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInMorphic [

	<script>
	self openInHost: BlMorphicWindowHost new
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openInSDL [

	<script>
	self openInHost: BlOSWindowSDL2Host new
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> openTranscript [

	MyTranscript := Transcript openLabel: self class instanceSide name , ' Transcript'.
	MyTranscript
		onAnnouncement: MorphDeleted
		send: #transcriptClosed
		to: self
]

{ #category : #initialization }
ToWorkspaceExample class >> resetTranscript [

	" self resetTranscript "
	MyTranscript := nil
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> transcriptAlreadyOpened [

	^ MyTranscript notNil
]

{ #category : #'instance creation' }
ToWorkspaceExample class >> transcriptClosed [

	MyTranscript announcer unsubscribe: self.
	self resetTranscript 
]

{ #category : #binding }
ToWorkspaceExample >> bindingOf: aString [

	"I want to have workspace that force the user to declare  
	variables. Still subclasses may want to do something else"
	
	| key |
	key := aString asSymbol.
	(bindings includesKey: key) ifFalse: [ 
		bindings at: key put: (GlobalVariable key: key value: nil) ].
	^ bindings at: key
]

{ #category : #bindings }
ToWorkspaceExample >> bindings [

	^ bindings 
]

{ #category : #'user interface' }
ToWorkspaceExample >> codeEditor [

	| st |
	st := textModel
		      withRowNumbers;
		      placeholderText:
			      (('Workspace example' , String cr , '- doit: Cmd-d')
				       asRopedText
				       fontSize: 24;
				       foreground: Color gray lighter;
				       yourself) ;
		      styler: (BlRBTextStyler new
				       isForWorkspace: true;
				       workspace: self;
				       fontName: AeFontManager defaultCodeFontFamilyName;
				       yourself);
		      addEditorShortcut: (BlShortcutWithAction new
				       combination: BlKeyCombination primaryD;
				       action: [ :aShortcutEvent :aShortcut | self doIt ];
				       name: 'Do it';
				       description: 'Run selected expression.');
		      yourself.
	^ st onWidget
]

{ #category : #accessing }
ToWorkspaceExample >> correctFrom: start to: stop with: aString [

	('correctFrom: ', start asString, ' to: ', stop asString, ' with: ', aString asString) traceCr
]

{ #category : #accessing }
ToWorkspaceExample >> doIt [

	textModel widgetDo: [ :widget | 
		| toDo |
		toDo := widget selectedText asString.
		toDo ifEmpty: [ toDo := widget text asString ].
		[ 
		OpalCompiler new
			source: toDo readStream;
			requestor: self;
			failBlock: [ ^ Object new ];
			evaluate ]
			on: OCUndeclaredVariableWarning
			do: [ :warn | warn traceCr ] ]
]

{ #category : #bindings }
ToWorkspaceExample >> hasBindingOf: aString [
	^ bindings includesKey: aString asSymbol
]

{ #category : #initialization }
ToWorkspaceExample >> initialize [
	super initialize.
	bindings := Dictionary new.
	textModel := ToAlbumModel new.

]

{ #category : #accessing }
ToWorkspaceExample >> isScripting [

	^ true
]

{ #category : #bindings }
ToWorkspaceExample >> notify: aString at: anInteger in: aString3 [ 
	('parse error: ', aString, ' at: ', anInteger asString) traceCr.
]

{ #category : #'user interface' }
ToWorkspaceExample >> open [

	self openInSpace: ToManager world
]

{ #category : #'user interface' }
ToWorkspaceExample >> openInSpace: aSpace [

	| editor frame |
	editor := self codeEditor.
	editor infinite requestFocus.
	editor showPlaceholder.
	frame := ToInnerWindow new title: 'Workspace'.
	frame addChild: editor.
	aSpace root addChild: frame.
"	aSpace addEventHandler: (BlEventHandler
			 on: BlSpaceClosedEvent
			 do: [ :evt | self class closeTranscript ])"
]

{ #category : #accessing }
ToWorkspaceExample >> text [

	^ textModel text
]
