Class {
	#name : #DiceTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
DiceTest >> testCreate2DicesAndBoth6Faces [
	"comment stating purpose of message"

	| dice diceTwo |
	
dice:= Dice withNumOfSides: 6.
diceTwo:= Dice withNumOfSides: 6.
self assert: dice amountSides equals: 6.
self assert: diceTwo amountSides equals: 6.

]

{ #category : #tests }
DiceTest >> testDiceCreatedWithNegativeFacesAndFails [
	"comment stating purpose of message"

self should: [ Dice withNumOfSides: (-3) ] raise: AssertionFailure .


]

{ #category : #tests }
DiceTest >> testDiceHas6Faces [
	"comment stating purpose of message"

	| dice |
	
dice:= Dice withNumOfSides: 6.
self assert: dice amountSides equals: 6.
]

{ #category : #tests }
DiceTest >> testDiceHas6FacesAndGetsAOne [
	"comment stating purpose of message"

	| dice value |
	
dice:= FixedDice withNumOfSides: 6.
self assert: dice amountSides equals: 6.
value:= dice roll.
self assert: value equals: 1.

]

{ #category : #tests }
DiceTest >> testDiceHas6FacesAndTestFullCicle [
	"comment stating purpose of message"

	| dice value |
	
dice:= FixedDice withNumOfSides: 6.
self assert: dice amountSides equals: 6.
value:= dice roll.
self assert: value equals: 1.
value:= dice roll.
self assert: value equals: 2.
value:= dice roll.
self assert: value equals: 3.
value:= dice roll.
self assert: value equals: 4.
value:= dice roll.
self assert: value equals: 5.
value:= dice roll.
self assert: value equals: 6.
value:= dice roll.
self assert: value equals: 1.


]
