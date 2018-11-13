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


    Implementation Points
"
Class {
	#name : #Speed,
	#superclass : #PermanentCard,
	#instVars : [
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
Speed >> cardModifierForPlayer: aPlayer [
	^
	player = aPlayer
	ifTrue: [ 1 ]
	ifFalse: [ 0 ]
]

{ #category : #playing }
Speed >> playedBy: aPlayer inGame: aJagerGame forPlayers: somePlayers [
	player := somePlayers.
	aJagerGame currentPlayer = aPlayer
	ifTrue:[ 	aJagerGame saveCard: self.
			aPlayer discard: self.
			aJagerGame addPermanentCard: self . ]
	ifFalse: [ AssertionFailure signal: 'Playing out of turn' ]
]
