"
Please comment me using the following template inspired by Class Responsibility Collaborator (CRC) design:

For the Class part:  State a one line summary. For example, ""I represent a paragraph of text"".

For the Responsibility part: Three sentences about my main responsibilities - what I do, what I know.

For the Collaborators Part: State my main collaborators and one line about how I interact with them. 

Public API and Key Messages

- message one   
- message two 
- (for bonus points) how to create instances.

   One simple example is simply gorgeous.
 
Internal Representation and Key Implementation Points.

    Instance Variables
	amountSides:		<Object>
	rolled:		<Object>


    Implementation Points
"
Class {
	#name : #FixedDice,
	#superclass : #Object,
	#instVars : [
		'amountSides',
		'rolled'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
FixedDice class >> withNumOfSides: anInteger [ 
	(anInteger <= 1) ifTrue: [ ^AssertionFailure signal: 'Dice cant have less than 2 faces' ].
	^ self new initializeWithSides: anInteger.
]

{ #category : #accesing }
FixedDice >> amountSides [
	^ amountSides
]

{ #category : #initialization }
FixedDice >> initializeWithSides: anInteger [ 
	amountSides := anInteger.
	rolled := 1.
]

{ #category : #rolling }
FixedDice >> roll [
	| actual |
	actual := rolled.
	rolled := rolled + 1.
	(rolled > amountSides) ifTrue: [ rolled := 1 ].
	 ^  actual.
	
]
