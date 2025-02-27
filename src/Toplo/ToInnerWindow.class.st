Class {
	#name : #ToInnerWindow,
	#superclass : #ToWindowElement,
	#traits : 'TToWidgetWithResizeGrips + TToWidgetWithContextMenu',
	#classTraits : 'TToWidgetWithResizeGrips classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'bar',
		'title',
		'titleLabel'
	],
	#category : #'Toplo-Widget-Window'
}

{ #category : #adding }
ToInnerWindow >> addChild: anElement [
	"Add a given element as a direct child to the space root"
	self
		deprecated: 'Send addChild: to root.'
		transformWith:
			'`@receiver addChild: `@arg'
				-> '`@receiver root addChild: `@arg'.

	self root addChild: anElement
]

{ #category : #accessing }
ToInnerWindow >> bar [

	^ bar ifNil: [ self bar: self defaultBar. bar ]
]

{ #category : #accessing }
ToInnerWindow >> bar: anElement [

	bar ifNotNil: [ 
		bar removeEventHandler: (bar userData at: #pullHandler).
		bar removeFromParent ].
	bar := anElement.
	bar userData at: #pullHandler put: (BlPullHandler new pullTarget: self).
	bar addEventHandler: (bar userData at: #pullHandler)
]

{ #category : #initialization }
ToInnerWindow >> defaultBar [

	| b close expand fill1 fill2 |
	b := ToPane horizontal
		     margin: (BlInsets all: 1);
		     border: self defaultBorder;
		     outskirts: BlOutskirts outside;
		     background: self defaultBarBackground;
				yourself.

	b layout: (BlGridLayout horizontal cellSpacing: 1).
	b when: BlDoubleClickEvent do: [ self maximize ].
	b when: BlMouseDownEvent do: [ self toFront ].
	close := ToButton new icon: (ToImage new innerImage: Smalltalk ui theme windowCloseForm).
	close 	icon border: (BlBorder paint: Color black).
	close whenClickedDo: [ self close ].
	expand := ToButton new icon: (ToImage new innerImage: Smalltalk ui theme windowMaximizeForm).
	expand whenClickedDo: [ self maximize ].

	fill1 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c | 
			         c vertical matchParent.
			         c horizontal matchParent ].
	fill2 := BlElement new
		         background: Color transparent;
		         constraintsDo: [ :c | 
			         c vertical matchParent.
			         c horizontal matchParent ].
	titleLabel := ToLabel new text: self title.
	
	b addChildren: { 
			close.
			fill1.
			titleLabel.
			fill2.
			expand }.
	^ b
]

{ #category : #initialization }
ToInnerWindow >> defaultBarBackground [
	
	^ Color veryLightGray alpha: 0.4
]

{ #category : #initialization }
ToInnerWindow >> defaultBorder [

	^ BlBorder paint: self defaultBorderPaint width: self defaultBorderWidth
]

{ #category : #initialization }
ToInnerWindow >> defaultBorderPaint [

	^ Color veryLightGray alpha: 0.8
]

{ #category : #initialization }
ToInnerWindow >> defaultBorderWidth [

	^ 3
]

{ #category : #initialization }
ToInnerWindow >> defaultRoot [

	^ super defaultRoot
		  margin: (BlInsets all: 1);
		  outskirts: BlOutskirts outside;
		  matchParent
]

{ #category : #initialization }
ToInnerWindow >> defaultRootBackground [

	^ Color white
]

{ #category : #initialization }
ToInnerWindow >> defaultRootLayout [

	^ BlBasicLayout uniqueInstance 
]

{ #category : #initialization }
ToInnerWindow >> defaultSize [

	^ 300@200
]

{ #category : #initialization }
ToInnerWindow >> defaultTitle [

	^ ''
]

{ #category : #initialization }
ToInnerWindow >> elements [

	^ { self bar. self root }
]

{ #category : #initialization }
ToInnerWindow >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self size: self defaultSize.
	self background: Color gray.
	self initializeGrips

]

{ #category : #'api - displaying' }
ToInnerWindow >> maximize [

	self
		relocate: 0 @ 0;
		size: self parent size
]

{ #category : #'api - displaying' }
ToInnerWindow >> show [
	"Open me in a window and show it to the user"

	self openInOBlSpace
]

{ #category : #accessing }
ToInnerWindow >> title [

	^ title ifNil: [ title := self defaultTitle ]
]

{ #category : #accessing }
ToInnerWindow >> title: aString [

	title := aString.
	titleLabel ifNotNil: [ titleLabel text: aString ]
]
