Class {
	#name : #BoardTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
BoardTest >> testCreateBoardWith100Spaces [

	| board |
	board := Board withSpaces: 100.
	self assert: board numSpaces equals: 100.
]
