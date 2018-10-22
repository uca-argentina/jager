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
	#name : #Game,
	#superclass : #Object,
	#instVars : [
		'players',
		'dices',
		'playerPositions',
		'boardSpaces',
		'status',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initializing }
Game class >> playedBy: aPlayerSet throwing: aDiceSet on: aBoard [
	^ self new
		playedBy: aPlayerSet
		throwing: aDiceSet
		on: aBoard
]

{ #category : #initializing }
Game class >> playedBy: aPlayerSet throwing: aDiceSet on: aBoard withLaps: someLaps [
	^ self new
		playedBy: aPlayerSet
		throwing: aDiceSet
		on: aBoard
		withLaps: someLaps
]

{ #category : #accessing }
Game >> changeStatusToFinished [
	status := FinishedStatus new.
]

{ #category : #play }
Game >> doSpaceEfect: aRanking inSpace: aSpace [
	aSpace doSpaceActionOn: playerPositions withCurrentPlayer: aRanking withSpaces: (boardSpaces size) andLaps: laps.

]

{ #category : #accessing }
Game >> find: aPlayer [
	^ playerPositions
				detect: [ :aRanking | aRanking player = aPlayer ].
]

{ #category : #initialization }
Game >> initializePlayerPositions [
	playerPositions addAll: (players collect: [ :player | playerPositions add:( Ranking PositionPlayer: player ) ]).
	
]

{ #category : #play }
Game >> playRound [
	| temporaryPlayer |
	status playRound.
	players
		do: [ :aPlayer | 
			temporaryPlayer :=(self find: aPlayer).
			self playTurn: temporaryPlayer.
			self doSpaceEfect: (self find: aPlayer) inSpace: (boardSpaces at:(temporaryPlayer position)).
			].
	self rankPlayers: laps.
	 
]

{ #category : #play }
Game >> playTurn: aRanking [
	aRanking advancePositionBy: self rollDices withSpaces: (boardSpaces size).
]

{ #category : #initialization }
Game >> playedBy: aPlayerSet throwing: aDiceSet on: aBoard [
	players := OrderedCollection new.
	playerPositions := OrderedCollection new.
	dices := OrderedCollection new.
	status := ActiveStatus new.
	players := aPlayerSet.
	dices := aDiceSet.
	boardSpaces := aBoard.
	self initializePlayerPositions
]

{ #category : #initialization }
Game >> playedBy: aPlayerSet throwing: aDiceSet on: aBoard withLaps: someLaps [
	players := OrderedCollection new.
	playerPositions := OrderedCollection new.
	dices := OrderedCollection new.
	status := ActiveStatus new.
	players := aPlayerSet.
	dices := aDiceSet.
	boardSpaces := aBoard.
	laps:= someLaps.
	self initializePlayerPositions
]

{ #category : #accessing }
Game >> playerNames [
	| playerNames |
	playerNames := OrderedCollection new.
	playerNames addAll: (players collect: [:player | player name]).
	^playerNames.

]

{ #category : #accessing }
Game >> players [
	^ players
]

{ #category : #play }
Game >> rankPlayers [

	playerPositions sort: #position descending, #name ascending.
	status isFinished: playerPositions length: (boardSpaces size) in: self.
	"As sorted collection:"
]

{ #category : #play }
Game >> rankPlayers: someLaps [

	playerPositions sort: #laps descending, #position descending, #name ascending.
	status isFinished: playerPositions length: (someLaps) in: self.
	"As sorted collection:"
]

{ #category : #play }
Game >> rollDices [
	^dices sumNumbers: [:dice | dice roll ].
]

{ #category : #play }
Game >> winner [
	^ (playerPositions at: 1) name.
]
