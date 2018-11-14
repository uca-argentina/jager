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


    Implementation Points
"
Class {
	#name : #RandomThingsTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
RandomThingsTest >> buildTemplateWith: aNumber [
	| gameBuilder |
	gameBuilder := JagerGameBuilder new.
	gameBuilder addBoardWithSpaces: 10 withLaps: 1 fixedWith: aNumber.
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addSequencedDiceWithSides: 6.
	^ gameBuilder
	
]

{ #category : #tests }
RandomThingsTest >> testPlayCardNotInHand [
	| game gameBuilder player|
	gameBuilder := self buildTemplateWith: 0.
	game := gameBuilder build.
	player := game currentPlayer.
	player 
		discardAllCards;
		addCard: 2;
		 playCard: Speed new inGame: game forPlayers: player.
	self should:[ player playCard: Speed new inGame: game forPlayers: player]raise: AssertionFailure description: 'player doesnt own card'.

]

{ #category : #tests }
RandomThingsTest >> testRandomAddCard [
	| game gameBuilder player|
	gameBuilder := self buildTemplateWith: 0.
	game := gameBuilder build.
	player := game currentPlayer.
	player 
		discardAllCards;
		addCard;addCard;addCard;addCard;addCard.
	self assert: player amountOfCards equals: 5.
]

{ #category : #tests }
RandomThingsTest >> testRandomMatch [
	| game gameBuilder player|
	gameBuilder := JagerGameBuilder new.
	gameBuilder addBoardWithSpaces: 10 withLaps: 1.
	gameBuilder addPlayerNamed: 'Santiago'.
	gameBuilder addDiceWithSides: 6.
	game := gameBuilder build.
	player := game currentPlayer.
	game playTurn.
	game playTurn.
	
]
