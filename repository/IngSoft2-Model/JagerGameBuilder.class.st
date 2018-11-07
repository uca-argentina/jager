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
	board:		<Object>
	dices:		<Object>
	name:		<Object>
	players:		<Object>


    Implementation Points
"
Class {
	#name : #JagerGameBuilder,
	#superclass : #Object,
	#instVars : [
		'players',
		'dices',
		'boardSpaces',
		'laps'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #build }
JagerGameBuilder >> addBoardWithSpaces: anAmountOfSpaces withLaps: anAmountOfLaps [
	
	 1 to: anAmountOfSpaces do: [:i | boardSpaces add: (Space createSpace)].
	laps:=anAmountOfLaps .
]

{ #category : #build }
JagerGameBuilder >> addBoardWithSpaces: anAmountOfSpaces withLaps: anAmountOfLaps fixedWith: aFixed [
	
	 1 to: anAmountOfSpaces do: [:i | boardSpaces add: (Space createSpaceFixed: aFixed)].
	laps:=anAmountOfLaps .
]

{ #category : #build }
JagerGameBuilder >> addDiceWithSides: anInteger [
	
	dices add:(Dice withNumOfSides: anInteger)
]

{ #category : #build }
JagerGameBuilder >> addPlayerNamed: aName [
	
    players add: aName.
]

{ #category : #build }
JagerGameBuilder >> addSequencedDiceWithSides: anInteger [
	
	dices add:(SequencedDice withNumOfSides: anInteger)
]

{ #category : #build }
JagerGameBuilder >> assertDicesNotEmpty [
	dices isEmpty
		ifTrue: [ AssertionFailure signal: 'can not create a game without dice' ]
]

{ #category : #build }
JagerGameBuilder >> assertGameHasABoard [
	boardSpaces isEmpty
		ifTrue: [ AssertionFailure signal: 'the game has no board' ]
]

{ #category : #build }
JagerGameBuilder >> assertPlayersNotEmpty [
	players isEmpty
		ifTrue: [ AssertionFailure signal: 'can not create a game without a player' ]
]

{ #category : #build }
JagerGameBuilder >> build [
	self
		assertPlayersNotEmpty;
		assertDicesNotEmpty;
		assertGameHasABoard.
	^ JagerGame
		initializePlayedBy: players
		throwing: dices
		on: boardSpaces
		withLaps: laps
]

{ #category : #initialization }
JagerGameBuilder >> initialize [
	players := OrderedCollection new.
	dices := OrderedCollection new.
	boardSpaces := OrderedCollection new.
]
