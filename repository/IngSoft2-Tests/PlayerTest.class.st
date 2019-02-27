Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerAdvance [
 | player cards |
player  := Player initializeAndPositionPlayer: 'Santiago'.
cards := OrderedCollection new.
player advancePositionBy: 5 withSpaces: 20 withCards: cards .
self assert: player position equals: 5.
self assert: player laps equals: 0.
]

{ #category : #tests }
PlayerTest >> testPlayerAdvanceAndChangeLaps [
 | player cards |
player  := Player initializeAndPositionPlayer: 'Santiago'.
cards := OrderedCollection new.
player advancePositionBy: 6 withSpaces: 5 withCards: cards .
self assert: player position equals: 1.
self assert: player laps equals: 1.
]

{ #category : #tests }
PlayerTest >> testPlayerAdvanceAndRecede [
 | player cards |
player  := Player initializeAndPositionPlayer: 'Santiago'.
cards := OrderedCollection new.
player advancePositionBy: 6 withSpaces: 20 withCards: cards .
self assert: player position equals: 6.
player recedePositionBy: 4 withSpaces: 20.
self assert: player position equals: 2.
]

{ #category : #tests }
PlayerTest >> testPlayerCreation [
 | player |
player  := Player initializeAndPositionPlayer: 'Santiago'.
self assert: player name equals: 'Santiago'.
self assert: player position equals: 0.
self assert: player laps equals: 0.
]

{ #category : #tests }
PlayerTest >> testPlayerRecedeAndChangeLaps [
 | player cards |
player  := Player initializeAndPositionPlayer: 'Santiago'.
cards := OrderedCollection new.
player advancePositionBy: 6 withSpaces: 5 withCards: cards .
self assert: player position equals: 1.
self assert: player laps equals: 1.
player recedePositionBy: 4 withSpaces: 5.
self assert: player position equals: 2.
]

{ #category : #tests }
PlayerTest >> testPlayerRecedeTo0 [
 | player cards |
player  := Player initializeAndPositionPlayer: 'Santiago'.
cards := OrderedCollection new.
player advancePositionBy: 6 withSpaces: 20 withCards: cards .
self assert: player position equals: 6.
player recedePositionBy: 8 withSpaces: 20.
self assert: player position equals: 0.
]

{ #category : #tests }
PlayerTest >> testPlayerRecedeWhenNegativeAdvance [
 | player cards |
player  := Player initializeAndPositionPlayer: 'Santiago'.
cards := OrderedCollection new.
player advancePositionBy: 6 withSpaces: 20 withCards: cards .
self assert: player position equals: 6.
player advancePositionBy: (-4) withSpaces: 20 withCards: cards .
self assert: player position equals: 2.
]
