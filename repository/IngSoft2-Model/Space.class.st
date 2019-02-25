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
	type:		<Object>


    Implementation Points
"
Class {
	#name : #Space,
	#superclass : #Object,
	#instVars : [
		'type'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #initialization }
Space class >> createSpace [
	|rand |
	rand := Random new.
	rand := rand nextInt: 100.
	"rand := rand asInteger."
	rand < 38
	ifTrue:[^Normal new].
	rand < 48
	ifTrue:[^CardGiver new].
	rand < 68
	ifTrue:[^WormHole new].
	rand < 88
	ifTrue:[^SpeedUp new].
	rand < 98
	ifTrue:[^MoonWalk new].
	rand < 100
	ifTrue:[^AtomicBomb new].
	
	
]

{ #category : #initialization }
Space class >> createSpaceFixed: aNumber [
	aNumber = 1
	ifTrue:[^Normal new].
	aNumber = 2
	ifTrue:[^CardGiver new].
	aNumber = 3
	ifTrue:[^WormHole new].
	aNumber = 4
	ifTrue:[^SpeedUp new].
	aNumber = 5
	ifTrue:[^MoonWalkFixed new].
	aNumber = 6
	ifTrue:[^AtomicBomb new].
	
	
]

{ #category : #playing }
Space >> doSpaceActionOn: aCollectionOfPlayers withCurrentPlayer: aPlayer withSpaces: someSpaces andLaps: someLaps [ 
	^ self subclassResponsibility
]
