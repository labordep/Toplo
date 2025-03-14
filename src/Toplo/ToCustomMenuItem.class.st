Class {
	#name : #ToCustomMenuItem,
	#superclass : #ToAbstractMenuItem,
	#instVars : [
		'innerElement'
	],
	#category : #'Toplo-Widget-Menu'
}

{ #category : #'t - initialization dresser' }
ToCustomMenuItem >> defaultDresser [

	^ ToBasicMenuItemDresser new
]

{ #category : #initialization }
ToCustomMenuItem >> initialize [

	super initialize.
	self initializeDresser 
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement [

	^ innerElement
]

{ #category : #accessing }
ToCustomMenuItem >> innerElement: anElement [

	innerElement := anElement.
	self addChild: anElement.
	anElement border: BlBorder empty
]
