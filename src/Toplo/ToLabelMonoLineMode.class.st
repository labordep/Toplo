Class {
	#name : #ToLabelMonoLineMode,
	#superclass : #ToLabelLineMode,
	#category : #'Toplo-Widget-Label'
}

{ #category : #initialization }
ToLabelMonoLineMode >> isMonoLine [ 

	^ true
]

{ #category : #initialization }
ToLabelMonoLineMode >> newTextElementIn: aLabel [

	^ ToLabelMonoLineInnerElement new
]
