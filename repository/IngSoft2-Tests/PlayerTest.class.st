Class {
	#name : #PlayerTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
PlayerTest >> testCreatePlayer [
	"comment stating purpose of message"

	| player |
	player:= Player named: 'jager'.
	self assert: player name equals: 'jager'.
]
