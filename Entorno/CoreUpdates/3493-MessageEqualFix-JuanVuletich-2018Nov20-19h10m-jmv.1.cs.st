'From Cuis 5.0 of 7 November 2016 [latest update: #3492] on 20 November 2018 at 7:10:56 pm'!

!Message methodsFor: 'comparing' stamp: 'jmv 11/20/2018 19:10:34'!
= aMessage

	"Any object is equal to itself"
	self == aMessage ifTrue: [ ^ true ].

	self class == aMessage class ifFalse: [ ^false ].
	selector = aMessage selector ifFalse: [ ^false ].
	lookupClass = aMessage lookupClass ifFalse: [ ^false ].
	^args literalEqual: aMessage arguments! !

