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
		'laps',
		'cards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Ranking class >> PositionPlayer: aPlayer [ 
	^ self new initializeAtStart: aPlayer.
]

{ #category : #accessing }
Ranking >> addCard [
	| aNumber |
	aNumber := (Random new) nextInt: 6.
	
	aNumber = 1 
	ifTrue: [ cards add: Overload new ].
	aNumber = 2 
	ifTrue: [ cards add: Speed new ].
	aNumber = 3
	ifTrue: [ cards add: Acceleration new ].
	aNumber = 4
	ifTrue: [ cards add: Cancellation new ].
	aNumber = 5
	ifTrue: [ cards add: Redo new ].
	aNumber = 6 
	ifTrue: [ cards add: Repeat new ].
]

{ #category : #accessing }
Ranking >> addCard: aNumber [
	aNumber = 1
	ifTrue: [ cards add: Overload new ].
	aNumber = 2 
	ifTrue: [ cards add: Speed new ].
	aNumber = 3
	ifTrue: [ cards add: Acceleration new ].
	aNumber = 4
	ifTrue: [ cards add: Cancellation new ].
	aNumber = 5
	ifTrue: [ cards add: Redo new ].
	aNumber = 6 
	ifTrue: [ cards add: Repeat new ].
]

{ #category : #accessing }
Ranking >> addLastCard: aCard [ 
	cards add: aCard.
]

{ #category : #accessing }
Ranking >> advancePositionBy: aNumberOfSpaces withSpaces: aBoardLength withCards: aCollectionOfCards [
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
Ranking >> cardModifications: aCollectionOfCards [
	^	(aCollectionOfCards sumNumbers: [:card | card cardModifierForPlayer: self]) .
]

{ #category : #playing }
Ranking >> discard: aCard [ 
	| card |
	card := cards detect:[:anOwnedCard | (anOwnedCard name) = (aCard name)].
	cards remove: card.
	
]

{ #category : #accessing }
Ranking >> getBombed [
	position := 0.
]

{ #category : #initialization }
Ranking >> initializeAtStart: aPlayer [ 
	player := aPlayer.
	position := 0.
	laps := 0.
	cards := OrderedCollection new.
	self addCard.
	self addCard.
]

{ #category : #accessing }
Ranking >> laps [
	^laps.
]

{ #category : #accessing }
Ranking >> name [
	^ player.
]

{ #category : #accessing }
Ranking >> playCard: aCard inGame: aJagerGame forCard: aCanceledCard [
	aCard playedBy: self inGame: aJagerGame forCard: aCanceledCard.
]

{ #category : #accessing }
Ranking >> playCard: aCard inGame: aGame forPlayers: somePlayers [
	aCard playedBy: self inGame: aGame forPlayers: somePlayers.
]

{ #category : #accessing }
Ranking >> player [
	^ player
]

{ #category : #accessing }
Ranking >> position [
	^position.
]

{ #category : #accessing }
Ranking >> recedeLaps: aNumberOfSpaces [
	| temporarySpaces |
	laps = 0
		ifTrue: [ position := 0 ]
		ifFalse: [ temporarySpaces := aNumberOfSpaces - position.
			position := position - temporarySpaces.
			laps := laps - 1 ]
]

{ #category : #accessing }
Ranking >> recedePositionBy: aNumberOfSpaces [
	(position - aNumberOfSpaces) negative
		ifTrue:
			[ self recedeLaps: aNumberOfSpaces ]
		ifFalse: [ position := position - aNumberOfSpaces ]
]
