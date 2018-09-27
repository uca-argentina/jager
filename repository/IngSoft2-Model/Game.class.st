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
		'name',
		'players',
		'numPlayers',
		'dices',
		'diceCount',
		'board',
		'playerPositions'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initializing }
Game class >> named: aString playedBy: aPlayerSet throwing: aDiceSet on: aBoard [ 
	^ self new named: aString playedBy: aPlayerSet throwing: aDiceSet on: aBoard .
]

{ #category : #play }
Game >> isFinished [
	^ playerPositions
		anySatisfy: [ :index | index findPosition >= board ]
]

{ #category : #initialization }
Game >> name [
	^name.
]

{ #category : #initialization }
Game >> named: aName playedBy: aPlayerSet throwing: aDiceSet on: aBoard [ 
	players := OrderedCollection new.
	playerPositions := OrderedCollection new.
	dices := OrderedCollection new.
	name := aName.
	players := aPlayerSet .
	dices := aDiceSet.
	board := aBoard.
	numPlayers := players size.
	diceCount := dices size.
	self positionPlayersAtBoardStart.
	
]

{ #category : #play }
Game >> playTurn [
	| player |
	self isFinished
		ifTrue: [ ^ self ].
	players
		do: [ :index | 
			player := playerPositions
				select: [ :current | current findName = index findName ].
			(player at: 1) advancePosition: self rollDices ].
	self positionPlayers
]

{ #category : #players }
Game >> playerNames [
	| playerNames |
	playerNames := OrderedCollection new.
	playerNames addAll: (players collect: [:player | player findName]).
	^playerNames.

]

{ #category : #players }
Game >> players [
	^ players
]

{ #category : #play }
Game >> positionPlayers [

	playerPositions sort .
	"As sorted collection:"
]

{ #category : #initialization }
Game >> positionPlayersAtBoardStart [
	playerPositions addAll: (players collect: [ :player | playerPositions add:( Ranking PositionPlayer: player ) ]).
	
]

{ #category : #play }
Game >> rollDices [
	| count |
	count := 0.
	count := dices sumNumbers: [:dice | dice roll ].
	^count.
]

{ #category : #play }
Game >> winner [
	^ ((playerPositions at: 1) findName).
]
