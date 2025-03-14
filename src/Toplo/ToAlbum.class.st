Class {
	#name : #ToAlbum,
	#superclass : #ToPane,
	#traits : 'TToWidget + TToElement + TAlbInfiniteDecorator + TToWidgetWithViewModel + TToWidgetWithTooltip + TToWidgetWithContextMenu + TToWidgetWithLayers + TToWidgetWithPlaceholder',
	#classTraits : 'TToWidget classTrait + TToElement classTrait + TAlbInfiniteDecorator classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithContextMenu classTrait + TToWidgetWithLayers classTrait + TToWidgetWithPlaceholder classTrait',
	#instVars : [
		'#editsFeedbackLayer',
		'#innerElement',
		'#edited => ObservableSlot'
	],
	#category : #'Toplo-Widget-Album'
}

{ #category : #'t - initialization dresser' }
ToAlbum >> defaultDresser [
	^ ToAlbumBasicDresser new
]

{ #category : #initialization }
ToAlbum >> defaultEditorElement [

	^ AlbEditorElement new
]

{ #category : #accessing }
ToAlbum >> edited [

	^ edited ifNil: [ edited := false ]
]

{ #category : #accessing }
ToAlbum >> edited: aBoolean [

	edited = aBoolean ifTrue: [ ^ self ].
	edited := aBoolean
]

{ #category : #'client - protocol' }
ToAlbum >> flash [

	self announce: (ToAlbumFlashRequested new client: self)
]

{ #category : #initialization }
ToAlbum >> initialize [

	self class initializeSlots: self.
	super initialize.
	self constraintsDo: [ :c | 
		c horizontal matchParent.
		c vertical matchParent ].
	self next: self defaultEditorElement.
	self addChild: self next.
	self whenTextEditedDo: [ self edited: true ].
	
	self initializeDresser
]

{ #category : #accessing }
ToAlbum >> innerElement [

	^ self next
]

{ #category : #'t - accessing layers' }
ToAlbum >> layerReferentElement [

		^ self 
]

{ #category : #layers }
ToAlbum >> placeholderText: aText [

	self placeholder: (ToAlbumPlaceholder new text: aText).
	self text size isZero ifTrue: [ self showPlaceholder ]
]

{ #category : #'transaction hook' }
ToAlbum >> requestCancel [

	self announce: (ToAlbumCancelRequested new client: self)
]

{ #category : #'transaction hook' }
ToAlbum >> requestSave [

	self announce: (ToAlbumSaveRequested new
			 client: self;
			 unacceptedEdits: self edited ;
			 yourself)
]

{ #category : #'transaction hook' }
ToAlbum >> saveResult: aBoolean [

	| announcement |
	self edited: aBoolean not.
	announcement := aBoolean
		                ifTrue: [ ToAlbumSaveAccepted new client: self ]
		                ifFalse: [ ToAlbumSaveDenied new client: self ].
	self announce: announcement
]

{ #category : #accessing }
ToAlbum >> text: aBlText [

	aBlText == self text ifTrue: [ ^ self ].
	self next text: aBlText.
	self edited: false
]

{ #category : #'transaction hook' }
ToAlbum >> whenCancelRequestedDo: aBlock [

	self whenAnnouncement: ToAlbumCancelRequested do: aBlock
]

{ #category : #'property change hook' }
ToAlbum >> whenEditedChangedDo: aBlock [

	"set a block to perform after that the text has been chanbed, and its action performed"

	self property: #edited whenChangedDo: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveAcceptedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveAccepted do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveAcceptedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveAccepted send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveDeniedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveDenied do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveDeniedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveDenied send: aSelector to: anObject
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveRequestedDo: aBlock [

	self whenAnnouncement: ToAlbumSaveRequested do: aBlock
]

{ #category : #'transaction hook' }
ToAlbum >> whenSaveRequestedSend: aSelector to: anObject [

	self whenAnnouncement: ToAlbumSaveRequested send: aSelector to: anObject
]

{ #category : #layers }
ToAlbum >> withEditsFeedbackLayer [

	editsFeedbackLayer ifNotNil: [ ^ self ].
	editsFeedbackLayer := ToAlbumEditsFeedbackLayer new.
	self addLayer: editsFeedbackLayer 
]

{ #category : #initialization }
ToAlbum >> withSaveCapability [

	self withEditsFeedbackLayer.

	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination primaryS;
			 action: [ :aShortcutEvent :aShortcut | self requestSave ];
			 name: 'Save';
			 description: 'Apply changes and save the source code (compile).').
	self addEditorShortcut: (BlShortcutWithAction new
			 combination: BlKeyCombination primaryL;
			 action: [ :aShortcutEvent :aShortcut | self requestCancel ];
			 name: 'Cancel';
			 description: 'Cancel changes and rollback the previous accepted source code.')
]

{ #category : #layers }
ToAlbum >> withoutEditsFeedback [

	editsFeedbackLayer ifNil: [ ^ self ].
	self removeLayer: editsFeedbackLayer.
	editsFeedbackLayer := nil
]

{ #category : #layers }
ToAlbum >> withoutPlaceholder [ 

	self hidePlaceholder 
]
