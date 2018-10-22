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
	#name : #Ranking,
	#superclass : #Object,
	#instVars : [
		'player',
		'position',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ranking class >> PositionPlayer: aPlayer [ 
	^ self new initializeAtStart: aPlayer.
]

{ #category : #Accessing }
Ranking >> advancePositionBy: aNumberOfSpaces [ 
	position := position + aNumberOfSpaces.
]

{ #category : #Accessing }
Ranking >> advancePositionBy: aNumberOfSpaces withSpaces: aBoardLength [
	((position + aNumberOfSpaces ) > aBoardLength )
	ifTrue: [ position := position + aNumberOfSpaces.
				position := position - aBoardLength.
				laps:= laps +1. ]
	ifFalse: [ position := position + aNumberOfSpaces. ]
]

{ #category : #initialization }
Ranking >> initializeAtStart: aPlayer [ 
	player := aPlayer.
	position := 0.
	laps := 0.
]

{ #category : #Accessing }
Ranking >> laps [
	^laps.
]

{ #category : #Accessing }
Ranking >> name [
	^ player.
]

{ #category : #Accessing }
Ranking >> player [
	^ player
]

{ #category : #Accessing }
Ranking >> position [
	^position.
]

{ #category : #Accessing }
Ranking >> recedePositionBy: aNumberOfSpaces withSpaces: aBoardLength [
|temporarySpaces|
	((position - aNumberOfSpaces ) < 0)
	ifTrue: [ 
		laps = 0
		ifTrue:[position := 0.]
		ifFalse:[
				temporarySpaces := aNumberOfSpaces - position.
				position := position - temporarySpaces.
				laps := laps -1.]
				]
	ifFalse: [ position := position - aNumberOfSpaces. ]
]
