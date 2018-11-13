Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #'as yet unclassified' }
GameTest >> buildTemplateWith: aNumber [
	| gameBuilder |
	gameBuilder := JagerGameBuilder new.
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith: aNumber.
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	^ gameBuilder
]

{ #category : #tests }
GameTest >> testAccelerationUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: 3;
		playCard: Acceleration new inGame: game forPlayers: player;
		addCard: 3;
		playCard: Acceleration new inGame: game forPlayers: player;
		addCard: 3;
		playCard: Acceleration new inGame: game forPlayers: player;
		addCard: 3;
		playCard: Acceleration new inGame: game forPlayers: player;
		addCard: 3;
		playCard: Acceleration new inGame: game forPlayers: player;
		addCard: 3;
		playCard: Acceleration new inGame: game forPlayers: player;
		addCard: 3;
		playCard: Acceleration new inGame: game forPlayers: player.
	1 to: 2 do: [ :i | game playTurn ].
	self should: [ game playTurn ] raise: AssertionFailure description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testAtomicBomb [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:99. 
	gameBuilder addPlayerNamed: 'Santiago'.

	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	game playTurn.

	game playTurn.	
	1 to: 3 do: [:i |game playTurn].
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testCancellationUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player.
	1 to: 6 do: [  :i |
		player 
		addCard: 4;
		playCard: Cancellation new inGame: game forCard: Speed new].
	1 to: 4 do: [ :i | game playTurn ].
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testCantPlayFinishedGame [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	game playTurn.
	game playTurn.
	game playTurn.
	game playTurn.
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testCardGiver [
	| game gameBuilder |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	1 to: 4 do: [:i | game playTurn. ].
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testGetTop3 [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new. 
	gameBuilder addBoardWithSpaces: 50 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.gameBuilder addPlayerNamed: 'Santiago2'.
	gameBuilder addPlayerNamed: 'Santiago3'.gameBuilder addPlayerNamed: 'Santiago4'.
	gameBuilder addSequencedDiceWithSides: 4.
	game := gameBuilder build.
	1 to: 52 do: [:i | game playTurn. ].
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
	self assert: game topThree equals: 'First is: Santiago4. Second is: Santiago3. Third is: Santiago2'.
]

{ #category : #tests }
GameTest >> testLaps [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new. 

	gameBuilder addBoardWithSpaces: 10 withLaps: 2 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	1 to: 5 do: [:i | game playTurn. ].
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testMoonwalk [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:95. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	1 to: 4 do: [:i |game playTurn].
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testNormalGame [
	| game gameBuilder|
	gameBuilder := JagerGameBuilder new.
	gameBuilder addBoardWithSpaces: 100 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addPlayerNamed: 'Albert'.
	gameBuilder addPlayerNamed: 'Juan'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addSequencedDiceWithSides: 7.
	gameBuilder addSequencedDiceWithSides: 8.
	game := gameBuilder build.
	game playTurn.
	game playTurn.
	1 to: 30 do: [:i | game playTurn. ].
	
	self assert: game winner equals: 'Juan'.

	
]

{ #category : #tests }
GameTest >> testOverloadUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: 1;
		playCard: Overload new inGame: game forPlayers: player;
		addCard: 1;
		playCard: Overload new inGame: game forPlayers: player;
		addCard: 1;
		playCard: Overload new inGame: game forPlayers: player;
		addCard: 1;
		playCard: Overload new inGame: game forPlayers: player;
		addCard: 1;
		playCard: Overload new inGame: game forPlayers: player;
		addCard: 1;
		playCard: Overload new inGame: game forPlayers: player;
		addCard: 1;
		playCard: Overload new inGame: game forPlayers: player.
	1 to: 500 do: [ :i | game playTurn ].
	self
		shouldnt:[ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testRedoUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 5;
		playCard: Redo new inGame: game forPlayers: player.
	1 to: 2 do: [ :i | game playTurn ].
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testRedoUsageNoCardsPlayed [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: 5;
		playCard: Redo new inGame: game forPlayers: player.
	1 to: 4 do: [ :i | game playTurn ].
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testRepeatUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player.
	1 to: 6 do: [  :i |
		player 
		addCard: 6;
		playCard: Repeat new inGame: game forPlayers: player].
	1 to: 2 do: [ :i | game playTurn ].
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testShortNomalGame [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new.
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:20. 
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addPlayerNamed: 'Nacho'.
	gameBuilder addPlayerNamed: 'Juan'.
	gameBuilder addPlayerNamed: 'Albert'.
	gameBuilder addSequencedDiceWithSides: 6.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	game playTurn.
	game playTurn.
	game playTurn.
	1 to: 2 do: [:i |game playTurn].
	self assert: game winner equals: 'Santiago'.
	self assert: 1 equals: 1.
	
]

{ #category : #tests }
GameTest >> testSpeedUp [
	| game gameBuilder |
	gameBuilder := self buildTemplateWith: 70.
	game := gameBuilder build.
	game playTurn.
	game playTurn.
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testSpeedUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 40.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: 2;
		playCard: Speed new inGame: game forPlayers: player.
	1 to: 2 do: [ :i | game playTurn ].
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testWormhole [
	| game gameBuilder |
	gameBuilder := self buildTemplateWith: 60.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	1 to: 5 do: [:i | game playTurn. ].
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
]
