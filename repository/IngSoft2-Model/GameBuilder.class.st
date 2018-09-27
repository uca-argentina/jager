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
	#name : #GameBuilder,
	#superclass : #Object,
	#instVars : [
		'players',
		'dices',
		'board',
		'name'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
GameBuilder class >> named: aName [
	^ self new named: aName
]

{ #category : #build }
GameBuilder >> addBoardWithSpaces: anInteger [
	
    board :=  anInteger 
]

{ #category : #build }
GameBuilder >> addDiceWithSides: anInteger [
	
	dices add:(Dice withNumOfSides: anInteger)
]

{ #category : #build }
GameBuilder >> addFixedDiceWithSides: anInteger [
	
	dices add:(FixedDice withNumOfSides: anInteger)
]

{ #category : #build }
GameBuilder >> addPlayerNamed: aName [
	
    players add: (Player named: aName).
]

{ #category : #build }
GameBuilder >> assertDicesNotEmpty [
	dices isEmpty
		ifTrue: [ AssertionFailure signal: 'can not create a game without dice' ]
]

{ #category : #build }
GameBuilder >> assertGameHasABoard [
	board isNaN
		ifTrue: [ AssertionFailure signal: 'the game has no board' ]
]

{ #category : #build }
GameBuilder >> assertGameHasAName [
	name isEmpty
		ifTrue: [ AssertionFailure signal: 'game has no name' ]
]

{ #category : #build }
GameBuilder >> assertPlayersNotEmpty [
	players isEmpty
		ifTrue: [ AssertionFailure signal: 'can not create a game without a player' ]
]

{ #category : #build }
GameBuilder >> build [
	self
		assertPlayersNotEmpty;
		assertDicesNotEmpty;
		assertGameHasAName;
		assertGameHasABoard.
	^ Game
		named: name
		playedBy: players
		throwing: dices
		on: board
]

{ #category : #initialization }
GameBuilder >> initialize [
	players := OrderedCollection new.
	dices := OrderedCollection new.
]

{ #category : #build }
GameBuilder >> named: aName [
	
    name := aName.
]
