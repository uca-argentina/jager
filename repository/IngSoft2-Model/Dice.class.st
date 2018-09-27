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


    Implementation Points
"
Class {
	#name : #Dice,
	#superclass : #Object,
	#instVars : [
		'amountSides'
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
]

{ #category : #rolling }
Dice >> roll [
| rand |
rand:= Random new.
rand nextInt: amountSides .
	 ^  rand.
	
]
