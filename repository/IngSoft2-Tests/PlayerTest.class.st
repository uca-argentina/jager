Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testPlayerCreation [
 | player |
player  := Player initializeAndPositionPlayer: 'Santiago'.
self assert: player name equals: 'Santiago'.
self assert: player position equals: 0.
self assert: player laps equals: 0.
self assert: (player getPrisionStatus) class equals: Free.

]
