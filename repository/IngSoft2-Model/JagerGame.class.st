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
	diceCount:		<Object>
	dices:		<Object>
	name:		<Object>
	numPlayers:		<Object>
	players:		<Object>


    Implementation Points
"
Class {
	#name : #JagerGame,
	#superclass : #Object,
	#instVars : [
		'players',
		'playingTurn',
		'dices',
		'playerPositions',
		'boardSpaces',
		'status',
		'laps',
		'lastSpace',
		'playedCards',
		'lastCard'
	],
	#classVars : [
		'PlayerCards'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
JagerGame class >> initializePlayedBy: aPlayerSet throwing: aDiceSet on: aBoard withLaps: someLaps [
	^ self new
		initializePlayedBy: aPlayerSet
		throwing: aDiceSet
		on: aBoard
		withLaps: someLaps
]

{ #category : #accessing }
JagerGame >> addPermanentCard: aPermanentCard [ 
	playedCards add:aPermanentCard.
]

{ #category : #accessing }
JagerGame >> changeStatusToFinished [
	status := FinishedStatus new.
]

{ #category : #accessing }
JagerGame >> currentPlayer [
	^ playerPositions detect:[:aRanking | aRanking player =  playingTurn current].
]

{ #category : #playing }
JagerGame >> discard: aCard [
	| card |
	card := playedCards detect: [ :aPlayedCard | aPlayedCard name = aCard name ].
	playedCards remove: card
]

{ #category : #playing }
JagerGame >> doSpaceEfectOn: aPlayer inSpace: aSpace [
	aSpace doSpaceActionOn: playerPositions withCurrentPlayer: aPlayer withSpaces: (boardSpaces size) andLaps: laps.

]

{ #category : #playing }
JagerGame >> getSpace: aPlayer [
 ^boardSpaces at:(aPlayer position)
	 
]

{ #category : #initialization }
JagerGame >> initializePlayedBy: aPlayerSet throwing: aDiceSet on: aBoard withLaps: someLaps [
	players := OrderedCollection new.
	playingTurn := CircularIterator iteratingOver: aPlayerSet.
	playerPositions := OrderedCollection new.
	dices := OrderedCollection new.
	playedCards := OrderedCollection new.
	status := ActiveStatus new.
	players := aPlayerSet.
	dices := aDiceSet.
	boardSpaces := aBoard.
	laps:= someLaps.
	lastSpace := Normal new.
	self initializePlayerPositions.
]

{ #category : #initialization }
JagerGame >> initializePlayerPositions [
	playerPositions := (players collect: [ :player | Player initializeAndPositionPlayer: player ]) asOrderedCollection
]

{ #category : #accessing }
JagerGame >> lastCard [
	^ lastCard
]

{ #category : #accessing }
JagerGame >> lastSpace [
	^ lastSpace
]

{ #category : #playing }
JagerGame >> maxRollDices [
	^dices sumNumbers: [:dice | dice amountSides ].
]

{ #category : #playing }
JagerGame >> playTurn [
	| aPlayer |
	status playTurn.
	aPlayer := playerPositions detect:[:aRanking | aRanking player =  playingTurn current].
	(aPlayer prision = True)
	ifTrue: [
					| rolled |
					rolled := self rollDices.
						(rolled = self maxRollDices)
					   	ifTrue: [
							aPlayer changePrisionStatus: False.
							aPlayer advancePositionBy: rolled withSpaces: (boardSpaces size) withCards: playedCards.]
					   ifFalse:[
						((aPlayer hasCard: GetOutOfJail new) = True)
								ifTrue: [aPlayer playCard: (GetOutOfJail new) inGame: self.
									aPlayer advancePositionBy: rolled withSpaces: (boardSpaces size) withCards: playedCards.]
						].
				]
						
	ifFalse: [aPlayer advancePositionBy: self  rollDices withSpaces: (boardSpaces size) withCards: playedCards.].
	(aPlayer position = 0)
	ifFalse: [self saveSpace: (boardSpaces at:(aPlayer position)).
	self doSpaceEfectOn: (self rankingOf: (aPlayer player)) inSpace: (boardSpaces at:(aPlayer position))].
	playingTurn next.
	self rankPlayers: laps.
	 
]

{ #category : #accessing }
JagerGame >> playerNames [
	^ players collect: [ :player | player name ]

]

{ #category : #accessing }
JagerGame >> players [
	^ players
]

{ #category : #playing }
JagerGame >> rankPlayers: someLaps [

	playerPositions sort: #laps descending, #position descending, #name ascending.
	status isFinished: playerPositions length: (someLaps) in: self.
]

{ #category : #accessing }
JagerGame >> rankingOf: aPlayer [
	^ playerPositions
				detect: [ :aRanking | aRanking player = aPlayer ].
]

{ #category : #playing }
JagerGame >> rollDices [
	^dices sumNumbers: [:dice | dice roll ].
]

{ #category : #accessing }
JagerGame >> saveCard: aCard [ 
	lastCard := aCard.
]

{ #category : #accessing }
JagerGame >> saveSpace: aSpace [ 
	lastSpace := aSpace.
]

{ #category : #accessing }
JagerGame >> topThree [
	^	 'First is: ', 
		(playerPositions at: 1) name,
		'. Second is: ', 
		(playerPositions at: 2) name,
		'. Third is: ', 
		(playerPositions at: 3) name.
]

{ #category : #accessing }
JagerGame >> winner [
	status checkFinalized.
	 ^   (playerPositions  at: 1) name.
]
