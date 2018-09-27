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

{ #category : #initialization }
Game >> initialize [
	players := OrderedCollection new.
	playerPositions := OrderedCollection new.
	dices := OrderedCollection new.
]

{ #category : #play }
Game >> isFinished [
	| position |
		 1 to: numPlayers do: [ :i | position := (playerPositions at: i) findPosition. position >= board ifTrue:[ ^true ] ].
		^false.
]

{ #category : #initialization }
Game >> name [
	^name.
]

{ #category : #initializing }
Game >> named: aName playedBy: aPlayerSet throwing: aDiceSet on: aBoard [ 
	name := aName.
	players addAll: aPlayerSet .
	dices addAll: aDiceSet.
	board := aBoard.
	numPlayers := players size.
	diceCount := dices size.
	self positionPlayersAtBoardStart.
	
]

{ #category : #play }
Game >> playTurn [
	| player |
	self isFinished
		ifFalse: [
			1 to: numPlayers do: [ :i | 
				player := (playerPositions select: [ :current | current findName = (players at: i) findName ]).
					(player at: 1) advancePosition: self rollDices ].
			self positionPlayers ]
]

{ #category : #players }
Game >> playerNames [
	| player playerNames |
	player := players first findName.
	playerNames := OrderedCollection new.
	1 to: numPlayers do: [ :i | player := (players at: i) findName. playerNames add: player].
	^playerNames.
]

{ #category : #players }
Game >> players [
	^ players
]

{ #category : #play }
Game >> positionPlayers [

	playerPositions sort.
]

{ #category : #playing }
Game >> positionPlayersAtBoardStart [
	1 to: (players size) do: [ :index | playerPositions add:( PlayerPosition PositionPlayer: (players at: index)) ].
]

{ #category : #play }
Game >> rollDices [
	| dice count |
	count := 0.
	1 to: diceCount do: [ :i | dice := (dices at: i). count := count + (dice roll)].
	^count.
]

{ #category : #play }
Game >> winner [
	^ ((playerPositions at: 1) findName).
]
