Class {
	#name : #BaselineOfToplo,
	#superclass : #BaselineOf,
	#category : #BaselineOfToplo
}

{ #category : #baselines }
BaselineOfToplo >> baseline: spec [

	<baseline>
	spec for: #common do: [ self baselineForCommon: spec ]
]

{ #category : #baselines }
BaselineOfToplo >> baselineForCommon: spec [

	self dependencies: spec.
	self registerPackages: spec
]

{ #category : #dependencies }
BaselineOfToplo >> dependencies: spec [

	spec
		baseline: 'OnBloc'
		with: [ spec repository: 'github://plantec/OnBloc/src' ].

	spec
		baseline: 'Album'
		with: [ spec repository: 'github://plantec/Album/src' ]
]

{ #category : #baselines }
BaselineOfToplo >> registerPackages: spec [
	"Core"

	spec 
		package: #Toplo 
		with: [ spec requires: #( #OnBloc #Album ) ].

	"Look and Feel"
	spec
		package: #'Toplo-LookAndFeel'
		with: [ spec requires: #( #Toplo ) ].
	spec
		package: #'Toplo-LookAndFeel-ToTheme'
		with: [ spec requires: #( #'Toplo-LookAndFeel' ) ].

	"Tests"
	spec 
		package: #'Toplo-Tests' 
		with: [ spec requires: #( #Toplo ) ].
	spec
		package: #'Toplo-LookAndFeel-Tests'
		with: [ spec requires: #( #'Toplo-LookAndFeel-ToTheme' ) ].
	spec
		package: #'Toplo-LookAndFeel-ToTheme-Tests'
		with: [ spec requires: #( #'Toplo-LookAndFeel-ToTheme' ) ].
]
