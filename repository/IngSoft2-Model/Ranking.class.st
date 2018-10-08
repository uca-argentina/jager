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
		'position'
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

{ #category : #initialization }
Ranking >> initializeAtStart: aPlayer [ 
	player := aPlayer.
	position := 0.
]

{ #category : #Accessing }
Ranking >> name [
	^ player name .
]

{ #category : #Accessing }
Ranking >> player [
	^ player
]

{ #category : #Accessing }
Ranking >> position [
	^position.
]
