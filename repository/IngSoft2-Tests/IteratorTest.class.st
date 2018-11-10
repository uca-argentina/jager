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
	#name : #IteratorTest,
	#superclass : #TestCase,
	#category : #'IngSoft2-Tests'
}

{ #category : #tests }
IteratorTest >> testIterator [
	| players iterator| 
	players := OrderedCollection new.
	players add: 'Santiago'.
	players add: 'Juan'.
	players add: 'Ignacio'.
	iterator := CircularIterator iteratingOver: players.
	self assert: iterator current equals: 'Santiago'.
	iterator next.
	self assert: iterator current equals: 'Juan'.
	iterator next.
	self assert: iterator current equals: 'Ignacio'.
	iterator next.
	self assert: iterator current equals: 'Santiago'.
	
]
