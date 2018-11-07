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
		'dices',
		'playerPositions',
		'boardSpaces',
		'status',
		'laps'
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
JagerGame >> changeStatusToFinished [
	status := FinishedStatus new.
]

{ #category : #play }
JagerGame >> doSpaceEfect: aRanking inSpace: aSpace [
	aSpace doSpaceActionOn: playerPositions withCurrentPlayer: aRanking withSpaces: (boardSpaces size) andLaps: laps.

]

{ #category : #accessing }
JagerGame >> find: aPlayer [
	^ playerPositions
				detect: [ :aRanking | aRanking player = aPlayer ].
]

{ #category : #initialization }
JagerGame >> initializePlayedBy: aPlayerSet throwing: aDiceSet on: aBoard withLaps: someLaps [
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

{ #category : #initialization }
JagerGame >> initializePlayerPositions [

	playerPositions addAll: (players collect: [ :player | ( Ranking PositionPlayer: player ) ]).

]

{ #category : #play }
JagerGame >> playRound [
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
JagerGame >> playTurn: aRanking [
	aRanking advancePositionBy: self rollDices withSpaces: (boardSpaces size).
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
JagerGame >> rankPlayers [

	playerPositions sort: #position descending, #name ascending.
	status isFinished: playerPositions length: (boardSpaces size) in: self.
	"As sorted collection:"
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
	^ (playerPositions at: 1) name.
]
