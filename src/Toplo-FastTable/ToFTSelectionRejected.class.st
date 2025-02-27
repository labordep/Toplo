"
I announce a rejected selection change (e.g. an attempt to select a row/column or cell outside the bounds of the table)

Description
-------------------

I store the direction of the change.

Public API and Key Messages
-------------------

•	#withDirection: is the sole constructor 


Internal Representation and Key Implementation Points.
------------------

Instance Variables
direction:	Direction of the attempted selection
"
Class {
	#name : #ToFTSelectionRejected,
	#superclass : #ToFTAnnouncement,
	#instVars : [
		'direction'
	],
	#category : #'Toplo-FastTable-Announcement'
}

{ #category : #'instance creation' }
ToFTSelectionRejected class >> withDirection: aDirection [
	^ self new
		direction: aDirection;
		yourself
]

{ #category : #accessing }
ToFTSelectionRejected >> direction [

	^ direction
]

{ #category : #accessing }
ToFTSelectionRejected >> direction: anObject [

	direction := anObject
]
