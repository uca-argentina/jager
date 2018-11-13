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
		'cards',
		'lastCard'
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
	cards add:aPermanentCard.
]

{ #category : #accessing }
JagerGame >> changeStatusToFinished [
	status := FinishedStatus new.
]

{ #category : #playing }
JagerGame >> currentPlayer [
	^ playerPositions detect:[:aRanking | aRanking player =  playingTurn current].
]

{ #category : #playing }
JagerGame >> discard: aCard [ 
	| card |
	card := cards detect:[:anOwnedCard | (anOwnedCard name) = (aCard name)].
	cards remove: card.
]

{ #category : #play }
JagerGame >> doSpaceEfect: aPlayer inSpace: aSpace [
	aSpace doSpaceActionOn: playerPositions withCurrentPlayer: aPlayer withSpaces: (boardSpaces size) andLaps: laps.

]

{ #category : #accessing }
JagerGame >> find: aPlayer [
	^ playerPositions
				detect: [ :aRanking | aRanking player = aPlayer ].
]

{ #category : #initialization }
JagerGame >> initializePlayedBy: aPlayerSet throwing: aDiceSet on: aBoard withLaps: someLaps [
	players := OrderedCollection new.
	playingTurn := CircularIterator iteratingOver: aPlayerSet.
	playerPositions := OrderedCollection new.
	dices := OrderedCollection new.
	cards := OrderedCollection new.
	status := ActiveStatus new.
	players := aPlayerSet.
	dices := aDiceSet.
	boardSpaces := aBoard.
	laps:= someLaps.
	self initializePlayerPositions.
]

{ #category : #initialization }
JagerGame >> initializePlayerPositions [

	playerPositions addAll: (players collect: [ :player | ( Ranking PositionPlayer: player ) ]).

]

{ #category : #accessing }
JagerGame >> lastCard [
	^ lastCard
]

{ #category : #accessing }
JagerGame >> lastSpace [
	^ lastSpace
]

{ #category : #play }
JagerGame >> playTurn [
	| aPlayer |
	status playTurn.
	aPlayer := playerPositions detect:[:aRanking | aRanking player =  playingTurn current].
	aPlayer advancePositionBy: self rollDices withSpaces: (boardSpaces size) withCards: cards.
	(aPlayer position = 0)
	ifFalse: [self saveSpace: (boardSpaces at:(aPlayer position)).
	self doSpaceEfect: (self find: (aPlayer player)) inSpace: (boardSpaces at:(aPlayer position))].
	playingTurn next.
	self rankPlayers: laps.
	 
]

{ #category : #accessing }
JagerGame >> playerNames [
	| playerNames |
	playerNames := OrderedCollection new.
	playerNames addAll: (players collect: [:player | player name]).
	^playerNames.

]

{ #category : #accessing }
JagerGame >> players [
	^ players
]

{ #category : #play }
JagerGame >> rankPlayers: someLaps [

	playerPositions sort: #laps descending, #position descending, #name ascending.
	status isFinished: playerPositions length: (someLaps) in: self.
	"As sorted collection:"
]

{ #category : #play }
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

{ #category : #play }
JagerGame >> topThree [
	^	 'First is: ', 
		(playerPositions at: 1) name,
		'. Second is: ', 
		(playerPositions at: 2) name,
		'. Third is: ', 
		(playerPositions at: 3) name.
]

{ #category : #play }
JagerGame >> winner [
	status checkFinalized.
	 ^   (playerPositions  at: 1) name.
]
