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
		'boardSpaces'
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

{ #category : #initialization }
Game >> initializePlayerPositions [
	playerPositions addAll: (players collect: [ :player | playerPositions add:( Ranking PositionPlayer: player ) ]).
	
]

{ #category : #play }
Game >> isFinished [
	^ playerPositions
		anySatisfy: [ :index | index position >= boardSpaces ]
		"detect: [ :each | each position >= boardSpaces  ]."
]

{ #category : #play }
Game >> playRound [
	| ranking |
	self isFinished
		ifTrue: [ AssertionFailure signal: 'Game has finished' ].
	players
		do: [ :aPlayer | 
			ranking := playerPositions
				detect: [ :aRanking | aRanking player = aPlayer ].
			ranking advancePositionBy: self rollDices ].
	self rankPlayers
]

{ #category : #initialization }
Game >> playedBy: aPlayerSet throwing: aDiceSet on: aBoard [
	players := OrderedCollection new.
	playerPositions := OrderedCollection new.
	dices := OrderedCollection new.
	players := aPlayerSet.
	dices := aDiceSet.
	boardSpaces := aBoard.
	self initializePlayerPositions
]

{ #category : #Accessing }
Game >> playerNames [
	| playerNames |
	playerNames := OrderedCollection new.
	playerNames addAll: (players collect: [:player | player name]).
	^playerNames.

]

{ #category : #Accessing }
Game >> players [
	^ players
]

{ #category : #play }
Game >> rankPlayers [

	playerPositions sort: #position descending, #name ascending.
	"As sorted collection:"
]

{ #category : #play }
Game >> rollDices [
	^dices sumNumbers: [:dice | dice roll ].
]

{ #category : #play }
Game >> winner [
	^ self isFinished
		ifTrue: [ (playerPositions at: 1) name ]
		ifFalse: [ AssertionFailure signal: 'Game not finished' ]
]
