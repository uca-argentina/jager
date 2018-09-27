Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testPlayAGameFourPlayerThreeDice678SidesBoardWith100Spaces [
	| game gameBuilder|
	gameBuilder := GameBuilder new.
	gameBuilder addBoardWithSpaces: 100.
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addPlayerNamed: 'Albert'.
	gameBuilder addPlayerNamed: 'Juan'.
	gameBuilder addFixedDiceWithSides: 6.
	gameBuilder addFixedDiceWithSides: 7.
	gameBuilder addFixedDiceWithSides: 8.
	gameBuilder named: 'jager'.
	game := gameBuilder build.
	game playTurn.
	self deny: game isFinished.
	game playTurn.
	1 to: 7 do: [:i | game playTurn. ].
	self assert: game isFinished.
	self assert: game winner equals: 'Juan'.

	
]

{ #category : #tests }
GameTest >> testPlayAGameFourPlayerTwoDice6SidesBoardWith10Spaces [
	| game gameBuilder |
	gameBuilder := GameBuilder new.
	gameBuilder named: 'jager'.
	gameBuilder addBoardWithSpaces: 10.
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addPlayerNamed: 'Juan'.
	gameBuilder addPlayerNamed: 'Albert'.
	gameBuilder addFixedDiceWithSides: 6.
	gameBuilder addFixedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	self deny: game isFinished.
	game playTurn.
	self assert: game isFinished.
	self assert: 1 equals: 1.
	
]

{ #category : #tests }
GameTest >> testPlayAGameOnePlayerOneDice6SidesBoardWith10Spaces [
	| game gameBuilder |
	gameBuilder := GameBuilder new. 
	gameBuilder named: 'jager'.
	gameBuilder addBoardWithSpaces: 10.
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addFixedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	self deny: game isFinished.
	1 to: 5 do: [:i | game playTurn. ].
	self assert: game isFinished.
]

{ #category : #tests }
GameTest >> testPlayAGameTwoPlayerTwoDice6SidesBoardWith10Spaces [
	| game gameBuilder |
	gameBuilder := GameBuilder new.
	gameBuilder named: 'jager'.
	gameBuilder addBoardWithSpaces: 10.
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addFixedDiceWithSides: 6.
	gameBuilder addFixedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	self deny: game isFinished.
	game playTurn.
	self assert: game isFinished.
	
]
