Class {
	#name : #ToEditableComboBoxHead,
	#superclass : #ToComboBoxHead,
	#classTraits : 'TObservable classTrait',
	#instVars : [
		'dataToTextConverter',
		'textToDataConverter'
	],
	#category : #'Toplo-Widget-ComboBox'
}

{ #category : #accessing }
ToEditableComboBoxHead >> dataToTextConverter [

	^ dataToTextConverter
]

{ #category : #accessing }
ToEditableComboBoxHead >> dataToTextConverter: aValuable [

	dataToTextConverter := aValuable
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultDataToTextConverter [

		^ [ :d | d ]

]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultPlaceholder [

	^ ToLabel new text: 'Enter text'; yourself
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultTextField [

	^ ToTextField new withoutLineWrapping 
]

{ #category : #initialization }
ToEditableComboBoxHead >> defaultTextToDataConverter [

		^ [ :d | d asString ]

]

{ #category : #'t - placeholder show/hide' }
ToEditableComboBoxHead >> hidePlaceholder [

	self textField hidePlaceholder 
]

{ #category : #initialization }
ToEditableComboBoxHead >> initialize [ 

	super initialize.
	self textField: self defaultTextField.
	self placeholder: self defaultPlaceholder.

	self dataToTextConverter: self defaultDataToTextConverter.
	self textToDataConverter: self defaultTextToDataConverter.
]

{ #category : #accessing }
ToEditableComboBoxHead >> noDataSelected [

	self showPlaceholder 
]

{ #category : #accessing }
ToEditableComboBoxHead >> placeholder [

	^ self textField placeholder
]

{ #category : #accessing }
ToEditableComboBoxHead >> placeholder: anElement [

	self textField placeholder: (anElement ifNil: [ self defaultPlaceholder ])
]

{ #category : #accessing }
ToEditableComboBoxHead >> selectData: aData [

	self hidePlaceholder.
	self textField text: (self dataToTextConverter value: aData)


]

{ #category : #'t - placeholder show/hide' }
ToEditableComboBoxHead >> showPlaceholder [

	self textField showPlaceholder 
]

{ #category : #accessing }
ToEditableComboBoxHead >> textField [ 

	^ self first
]

{ #category : #accessing }
ToEditableComboBoxHead >> textField: aTextField [

	self first: aTextField 
]

{ #category : #accessing }
ToEditableComboBoxHead >> textToDataConverter [

	^ textToDataConverter
]

{ #category : #accessing }
ToEditableComboBoxHead >> textToDataConverter: aValuable [

	textToDataConverter := aValuable
]
