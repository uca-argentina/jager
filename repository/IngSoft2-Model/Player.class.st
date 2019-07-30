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
	#name : #Player,
	#superclass : #Object,
	#instVars : [
		'player',
		'position',
		'laps',
		'cards',
		'prisionStatus'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Player class >> initializeAndPositionPlayer: aName [
	^ self new initializeAtStart: aName.
]

{ #category : #accessing }
Player >> addCard [
	self addCard: {
		Overload new.
		Speed new.
		Acceleration new.
		Cancellation new.
		Redo new.
		GetOutOfJail new.
		Repeat new
	} atRandom.

]

{ #category : #accessing }
Player >> addCard: aCard [
	cards add: aCard
]

{ #category : #accessing }
Player >> addLastCard: aCard [ 
	cards add: aCard.
]

{ #category : #playing }
Player >> advancePositionBy: aNumberOfSpaces withSpaces: aBoardLength withCards: aCollectionOfCards [ 
"aPlayer advancePositionBy: self  rollDices withSpaces: (boardSpaces size) withCards: cards."
		| spaces |
	spaces := cards isEmptyOrNil
		ifTrue: [ aNumberOfSpaces ]
		ifFalse: [ aNumberOfSpaces + (self cardModifications: aCollectionOfCards) ]."sumo o resto los efectos que tengo"
	spaces negative
		ifTrue: [ self recedePositionBy: spaces negated ]"si tengo que retroceder"
		ifFalse: [ position + spaces > aBoardLength
				ifTrue: [ position := position + spaces.
					position := position - aBoardLength.
					laps := laps + 1 ]
				ifFalse: [ position := position + spaces ] ]
]

{ #category : #accessing }
Player >> amountOfCards [
	 ^ cards size.
]

{ #category : #playing }
Player >> canMoveWithDiceRoll: rolled withMaxRollDices: maxValueOfDices inGame: aGame [
	^ (prisionStatus canMove: self inGame: aGame withThrow: rolled maxRollDices: maxValueOfDices).
]

{ #category : #playing }
Player >> cardModifications: aCollectionOfCards [
	^	(aCollectionOfCards sumNumbers: [:card | card cardModifierForPlayer: self]) .
]

{ #category : #playing }
Player >> discard: aCard [ 
	| card |
	 [card := cards detect:[:anOwnedCard | (anOwnedCard name) = (aCard name)].]
	on: Error do:[AssertionFailure signal: 'player doesnt own card' ].
	cards remove: card.
	

]

{ #category : #playing }
Player >> discardAllCards [ 
	 cards := OrderedCollection new.
]

{ #category : #playing }
Player >> getBombed [
	position := 0.
]

{ #category : #playing }
Player >> getOutOfPrision [
	prisionStatus:= Free new.
]

{ #category : #accessing }
Player >> getPrisionStatus [
	^ prisionStatus.
]

{ #category : #playing }
Player >> goToPrision [
	prisionStatus:= Prisioner new.
]

{ #category : #accessing }
Player >> hasCard: aCard [ 
		| card |
	card := cards detect:[:anOwnedCard | (anOwnedCard name) = (aCard name)]ifNone:[].
   (card name = aCard name)
	ifTrue: [ ^true. ] ifFalse: [ ^false. ]

]

{ #category : #initialization }
Player >> initializeAtStart: aPlayer [ 
	player := aPlayer.
	position := 0.
	laps := 0.
	cards := OrderedCollection new.
	prisionStatus := Free new.
	self addCard.
	self addCard.
]

{ #category : #accessing }
Player >> laps [
	^laps.
]

{ #category : #accessing }
Player >> name [
	^ player.
]

{ #category : #playing }
Player >> playCard: aCard inGame: aJagerGame [
	aCard playedBy: self inGame: aJagerGame.

]

{ #category : #playing }
Player >> playCard: aCard inGame: aJagerGame forCard: aCanceledCard [
	aCard playedBy: self inGame: aJagerGame forCard: aCanceledCard.
]

{ #category : #playing }
Player >> playCard: aCard inGame: aGame forPlayers: somePlayers [
	aCard playedBy: self inGame: aGame forPlayer: somePlayers.
]

{ #category : #accessing }
Player >> player [
	^ player
]

{ #category : #accessing }
Player >> position [
	^position.
]

{ #category : #playing }
Player >> recedeLaps: aNumberOfSpaces [
	| temporarySpaces |
	laps = 0
		ifTrue: [ position := 0 ]
		ifFalse: [ temporarySpaces := aNumberOfSpaces - position.
			position := position - temporarySpaces.
			laps := laps - 1 ]
]

{ #category : #playing }
Player >> recedePositionBy: aNumberOfSpaces [
	(position - aNumberOfSpaces) negative
		ifTrue:
			[ self recedeLaps: aNumberOfSpaces.]
		ifFalse: [ position := position - aNumberOfSpaces ]
]
