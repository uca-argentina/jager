Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
GameTest >> testPlayAGameFourPlayerThreeDice678SidesBoardWith100SpacesFixededNornal [
	| game gameBuilder|
	gameBuilder := GameBuilder new.
	gameBuilder addBoardWithSpaces: 100 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addPlayerNamed: 'Albert'.
	gameBuilder addPlayerNamed: 'Juan'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addSequencedDiceWithSides: 7.
	gameBuilder addSequencedDiceWithSides: 8.
	game := gameBuilder build.
	game playRound.
	game playRound.
	1 to: 6 do: [:i | game playRound. ].
	
	self assert: game winner equals: 'Juan'.

	
]

{ #category : #tests }
GameTest >> testPlayAGameFourPlayerTwoDice6SidesBoardWith10SpacesFixedNormal [
	| game gameBuilder |
	gameBuilder := GameBuilder new.
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addPlayerNamed: 'Juan'.
	gameBuilder addPlayerNamed: 'Albert'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playRound.
	game playRound.
	self assert: game winner equals: 'Nacho'.
	self assert: 1 equals: 1.
	
]

{ #category : #tests }
GameTest >> testPlayAGameOnePlayerOneDice6SidesBoardWith10SpacesAndTwoLapsFixedNormal [
	| game gameBuilder |
	gameBuilder := GameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 2 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playRound.
	1 to: 5 do: [:i | game playRound. ].
	self should:[ game playRound ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testPlayAGameOnePlayerOneDice6SidesBoardWith10SpacesFixedNormal [
	| game gameBuilder |
	gameBuilder := GameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playRound.
	game playRound.
	game playRound.
	game playRound.
	game playRound.
	self should:[ game playRound ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testPlayAGameOnePlayerOneDice6SidesBoardWith10SpacesFixedSpeedUp [
	| game gameBuilder |
	gameBuilder := GameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:70. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playRound.
	game playRound.
	self should:[ game playRound ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testPlayAGameOnePlayerOneDice6SidesBoardWith10SpacesFixedWormHole [
	| game gameBuilder |
	gameBuilder := GameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:60. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 15.
	game := gameBuilder build.
	1 to: 8 do: [:i | game playRound. ].
	self should:[ game playRound ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testPlayAGameTwoPlayerTwoDice6SidesBoardWith10SpacesFixedAtomic [
	| game gameBuilder |
	gameBuilder := GameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:99. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playRound.
	game playRound.
	game playRound.
	self should:[ game playRound ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testPlayAGameTwoPlayerTwoDice6SidesBoardWith10SpacesFixedMoonwalk [
	| game gameBuilder |
	gameBuilder := GameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:95. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playRound.
	game playRound.
	game playRound.
	self should:[ game playRound ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testPlayAGameTwoPlayerTwoDice6SidesBoardWith10SpacesFixedNormal [
	| game gameBuilder |
	gameBuilder := GameBuilder new.
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	1 to: 2 do: [:i | game playRound. ].
	self should:[ game playRound ]raise: AssertionFailure description: 'Game is Finished'.
]
