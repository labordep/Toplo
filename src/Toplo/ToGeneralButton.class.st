Class {
	#name : #ToGeneralButton,
	#superclass : #ToElement,
	#traits : 'TToWidget + TToEnableable + TToClickable + TToWidgetWithTooltip + TToWidgetWithViewModel + TToWidgetWithContextMenu',
	#classTraits : 'TToWidget classTrait + TToEnableable classTrait + TToClickable classTrait + TToWidgetWithTooltip classTrait + TToWidgetWithViewModel classTrait + TToWidgetWithContextMenu classTrait',
	#instVars : [
		'client'
	],
	#category : #'Toplo-Widget-Button'
}

{ #category : #'t - click behavior' }
ToGeneralButton >> client [

	^ client
]

{ #category : #accessing }
ToGeneralButton >> client: anObject [

	client := anObject
]

{ #category : #'t - initialization dresser' }
ToGeneralButton >> defaultDresser [

	^ ToGeneralButtonDresser new
]

{ #category : #initialization }
ToGeneralButton >> initialize [ 

	self class initializeSlots: self.
	super initialize.
	self initializeDresser 

]
