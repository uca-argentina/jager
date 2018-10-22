"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'amountSides',
		'random'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Dice class >> withNumOfSides: anInteger [ 
	(anInteger <= 1) ifTrue: [ ^AssertionFailure signal: 'Dice cant have less than 2 faces' ].
	^ self new initializeWithSides: anInteger.
]

{ #category : #accesing }
Dice >> amountSides [
	^ amountSides
]

{ #category : #initialization }
Dice >> initializeWithSides: anInteger [ 
	amountSides := anInteger.
	random:= Random new.
]

{ #category : #rolling }
Dice >> roll [

	 ^  ((random nextInt: amountSides) asInteger).
	
]
