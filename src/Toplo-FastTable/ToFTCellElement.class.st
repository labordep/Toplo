"
I represent a cell for the table. 

Description
------------------

I contains other Morph that need to be render. I should be answered in ToFTDataSource>>#cellTable:column:row:, with this method a ToFTTableContainer can display all the needed cells.

Technically, ToFTDataSource can answer  any kind of morph, but I'm better prepared  for the role so is recommendable  to  use me.

Public API and Key Messages
-------------------

- #withTopSeparator 		this is use to put a separator before the cell. (For exmple on a ToFTOutlineDataSource).

Example
-------------------

ToFTCellMorph new
		addMorphBack: 'Example' asMorph;
		withTopSeparator;
		openInWindow.
 
Internal Representation and Key Implementation Points.
-----------------

    Instance Variables
	topSeparator:		This is a boolean to know if the cell need a topSeparator.

"
Class {
	#name : #ToFTCellElement,
	#superclass : #ToFTSelectableElement,
	#instVars : [
		'topSeparator'
	],
	#category : #'Toplo-FastTable-Base'
}

{ #category : #layout }
ToFTCellElement >> defaultLayout [ 

	^ BlLinearLayout horizontal 
]

{ #category : #drawing }
ToFTCellElement >> drawOn: aCanvas [
	super drawOn: aCanvas.
	topSeparator
		ifTrue: [ aCanvas line: bounds topLeft to: bounds topRight color: self seperatorColor ]
]

{ #category : #'event handling' }
ToFTCellElement >> handlesMouseOver: evt [
	self table ifNotNil: [ :table | ^ table selectionModeStrategy allowsCellSelection ].
	^ false
]

{ #category : #initialization }
ToFTCellElement >> initialize [
	super initialize.
	topSeparator := false.
	self layout: self defaultLayout.
	self vFitContent.
	self flag: 'TODO'.
	true ifTrue: [ ^ self ].
	self
		clipSubmorphs: true;
		layoutPolicy: TableLayout new;
		hResizing: #spaceFill;
		vResizing: #spaceFill;
		listDirection: #leftToRight;
		listCentering: #topLeft;
		wrapCentering: #center
]

{ #category : #drawing }
ToFTCellElement >> seperatorColor [
	^ self theme scrollbarColor
]

{ #category : #accessing }
ToFTCellElement >> withTopSeparator [
	topSeparator := true
]
