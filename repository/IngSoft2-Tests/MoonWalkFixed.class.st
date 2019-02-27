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

    Instance Variables
	spaces:		<Object>


    Implementation Points
"
Class {
	#name : #MoonWalkFixed,
	#superclass : #Space,
	#instVars : [
		'spaces'
	],
	#category : #'IngSoft2-Tests'
}

{ #category : #playing }
MoonWalkFixed >> doSpaceActionOn: aCollectionOfPlayers withCurrentPlayer: aPlayer withSpaces: amountSpaces andLaps: laps [
	aCollectionOfPlayers do: [:player | aPlayer = player ifFalse: [player recedePositionBy: spaces withSpaces: amountSpaces ]].
]

{ #category : #initialization }
MoonWalkFixed >> initialize [
	spaces := 2.
]
