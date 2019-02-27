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
	#name : #CircularIterator,
	#superclass : #Object,
	#instVars : [
		'players',
		'index',
		'maxIndex'
	],
	#category : #'IngSoft2-Model'
}

{ #category : #'instance creation' }
CircularIterator class >> iteratingOver: aCollection [ 
	^ self new initializeWithCollection: aCollection.
]

{ #category : #accessing }
CircularIterator >> current [
	^ players at: index.
]

{ #category : #initialization }
CircularIterator >> initializeWithCollection: aCollection [ 
	players := aCollection.
	index := 1.
	maxIndex := aCollection size.
	
]

{ #category : #modifying }
CircularIterator >> inverseOrder [
	| invertPlayers |
	invertPlayers := OrderedCollection new.
	invertPlayers addAll: players. 
	players removeAll.
	index := maxIndex - index + 1.
	invertPlayers reverseDo: [ :player | players add: player  ] 
	
]

{ #category : #modifying }
CircularIterator >> next [
	index := index + 1 <= maxIndex
		ifTrue: [ index + 1 ]
		ifFalse: [ 1 ]
]
