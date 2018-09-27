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
	player:		<Object>
	position:		<Object>


    Implementation Points
"
Class {
	#name : #PlayerPosition,
	#superclass : #Object,
	#instVars : [
		'player',
		'position'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
PlayerPosition class >> PositionPlayer: aPlayer [ 
	^ self new positionPlayer: aPlayer.
]

{ #category : #positioning }
PlayerPosition >> <= aPlayerPosition [ 
	^position >= (aPlayerPosition findPosition).
]

{ #category : #Accessing }
PlayerPosition >> advancePosition: aNumberOfSpaces [ 
	position := position + aNumberOfSpaces.
]

{ #category : #Accessing }
PlayerPosition >> findName [
	^ player findName .
]

{ #category : #Accessing }
PlayerPosition >> findPosition [
	^position.
]

{ #category : #initialization }
PlayerPosition >> positionPlayer: aPlayer [ 
	player := aPlayer.
	position := 0.
]
