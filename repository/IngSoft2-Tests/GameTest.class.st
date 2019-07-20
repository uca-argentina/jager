Class {
	#name : #GameTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #templates }
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
	gameBuilder := self buildTemplateWith: 1.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	self assert: player position equals: 1.
	player

		addCard: Acceleration new;
		playCard: Acceleration new inGame: game forPlayers: player.
	game playTurn.
	self assert: player position equals: 4.
		player
		addCard: Acceleration new;
		playCard: Acceleration new inGame: game forPlayers: player.
	game playTurn.
	self assert: player position equals: 9.
]

{ #category : #tests }
GameTest >> testAtomicBomb [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:6. 
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
GameTest >> testCancellationJoinRedoUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 1.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	self assert: player position equals: 1.
	player
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player.
	player 
		addCard: Cancellation new;
		playCard: Cancellation new inGame: game forCard: Speed new.
	player addCard: Redo new.

	player playCard: Redo new inGame: game forCard: Speed new. 
	game playTurn.
	self assert: player position equals: 3.
]

{ #category : #tests }
GameTest >> testCancellationUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 1.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	self assert: player position equals: 1.
	player
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player.
	player 
		addCard: Cancellation new;
		playCard: Cancellation new inGame: game forCard: Speed new.
	game playTurn.
	self assert: player position equals: 3.
]

{ #category : #tests }
GameTest >> testCantPlayFinishedGame [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new. 
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:1. 
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
GameTest >> testCarcel [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 7.
	"gameBuilder addSequencedDiceWithSides: 4."
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player addCard: GetOutOfJail new.
	game playTurn.
	player addCard: GetOutOfJail new.
	game playTurn.
	player addCard: GetOutOfJail new.
	game playTurn.
	player addCard: GetOutOfJail new.
	game playTurn.
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
]

{ #category : #tests }
GameTest >> testCardGiver [
	| game gameBuilder |
	gameBuilder := self buildTemplateWith: 2.
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
	gameBuilder addBoardWithSpaces: 50 withLaps: 1 fixedWith:1. 
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

	gameBuilder addBoardWithSpaces: 10 withLaps: 2 fixedWith:1. 
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
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:5. 
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
	gameBuilder addBoardWithSpaces: 100 withLaps: 1 fixedWith:1. 
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
	gameBuilder := self buildTemplateWith: 1.
	game := gameBuilder build.
	player := game currentPlayer.
	player
		addCard: Overload new;
		playCard: Overload new inGame: game forPlayers: player.
	game playTurn.
	self assert: player position equals: 0.
	game playTurn.
	self assert: player position equals: 0.
	game playTurn.
	self assert: player position equals: 1.
	player 	
		addCard: Overload new;
		playCard: Overload new inGame: game forPlayers: player;
		addCard: Overload new;
		playCard: Overload new inGame: game forPlayers: player.
	game playTurn.
	self assert: player position equals: 0.
]

{ #category : #tests }
GameTest >> testRedoUsage [
	| game gameBuilder player |
	gameBuilder := self buildTemplateWith: 1.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: Speed new;
		playCard: Speed new inGame: game forPlayers: player;
		addCard: Redo new;
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
	gameBuilder := self buildTemplateWith: 1.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	player
		addCard: Redo new;
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
	gameBuilder := self buildTemplateWith: 4.
	game := gameBuilder build.
	game playTurn.
	player := game currentPlayer.
	1 to: 10 do: [ :i | player
		addCard: Repeat new;
		playCard: Repeat new inGame: game forPlayers: player.].
	game playTurn.
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testShortNomalGame [
	| game gameBuilder |
	gameBuilder := JagerGameBuilder new.
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith:1. 
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
	gameBuilder := self buildTemplateWith: 4.
	game := gameBuilder build.
	game playTurn.
	game playTurn.
	self
		should: [ game playTurn ]
		raise: AssertionFailure
		description: 'Game is Finished'
]

{ #category : #tests }
GameTest >> testWormhole [
	| game gameBuilder |
	gameBuilder := self buildTemplateWith: 3.
	gameBuilder addSequencedDiceWithSides: 6.
	game := gameBuilder build.
	1 to: 5 do: [:i | game playTurn. ].
	self should:[ game playTurn ]raise: AssertionFailure description: 'Game is Finished'.
]
