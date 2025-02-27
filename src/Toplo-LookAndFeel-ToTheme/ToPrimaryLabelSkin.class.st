Class {
	#name : #ToPrimaryLabelSkin,
	#superclass : #ToAbstractLabelSkin,
	#category : #'Toplo-LookAndFeel-ToTheme-Skins - Label'
}

{ #category : #accessing }
ToPrimaryLabelSkin class >> type [

	^ #primary
]

{ #category : #built }
ToPrimaryLabelSkin >> builtForeground [

	^ self theme colorTextLightSolid
]

{ #category : #built }
ToPrimaryLabelSkin >> builtTextAttributes [

	| ropedText |
	ropedText := '' asRopedText.
	ropedText lineSpacing: self theme lineHeight.
	ropedText defaultFontSize: self theme fontSize.
	ropedText defaultFontName: self theme fontFamilyCode.
	ropedText weight: self theme fontWeightStrong.

	^ ropedText rope attributes
]
