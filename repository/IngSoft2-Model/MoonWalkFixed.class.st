Class {
	#name : #MoonWalkFixed,
	#superclass : #Space,
	#instVars : [
		'spaces'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #playing }
MoonWalkFixed >> doSpaceActionOn: aCollectionOfPlayers withCurrentPlayer: aPlayer withSpaces: amountSpaces andLaps: laps [
	aCollectionOfPlayers do: [:player | aPlayer = player ifFalse: [player recedePositionBy: spaces ]].
]

{ #category : #initialization }
MoonWalkFixed >> initialize [
	spaces := 2.
]
