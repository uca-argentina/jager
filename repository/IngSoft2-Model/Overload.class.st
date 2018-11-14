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
	#name : #Overload,
	#superclass : #PermanentCard,
	#instVars : [
		'player'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #accessing }
Overload >> advancePositionBy: aNumberOfSpaces withSpaces: aBoardLength withCards: aCollectionOfCards [
	| spaces |
	spaces := cards isEmptyOrNil
		ifFalse: [ aNumberOfSpaces + (self cardModifications: aCollectionOfCards) ]
		ifTrue: [ aNumberOfSpaces ].
	spaces negative
		ifTrue: [ self recedePositionBy: spaces negated ]
		ifFalse: [ position + spaces > aBoardLength
				ifTrue: [ position := position + spaces.
					position := position - aBoardLength.
					laps := laps + 1 ]
				ifFalse: [ position := position + spaces ] ]
]

{ #category : #playing }
Overload >> cardModifierForPlayer: aPlayer [
	^
	player = aPlayer
	ifTrue: [ -2 ]
	ifFalse:[0]
]

{ #category : #playing }
Overload >> playedBy: aPlayer inGame: aJagerGame forPlayers: somePlayers [
	player := somePlayers.
	aJagerGame currentPlayer = aPlayer
	ifTrue:[ aJagerGame saveCard: self.
			aPlayer discard: self.	
			aJagerGame addPermanentCard: self . ]
	ifFalse: [ AssertionFailure signal: 'Playing out of turn' ]
]