'From Cuis 5.0 of 7 November 2016 [latest update: #3358] on 9 July 2018 at 5:31:34 pm'!

!False methodsFor: 'controlling' stamp: 'HAW 7/9/2018 17:27:55'!
or: aBlock1 or: aBlock2

	"I sending value to aBlock2 to optimize the generated byte-code - Hernan"
	^aBlock1 value or: [ aBlock2 value ]
! !

!False methodsFor: 'controlling' stamp: 'HAW 7/9/2018 17:28:10'!
or: aBlock1 or: aBlock2 or: aBlock3

	"I sending value to aBlock3 to optimize the generated byte-code - Hernan"
	^aBlock1 value or: [ aBlock2 value or: [ aBlock3 value ] ]! !

!False methodsFor: 'controlling' stamp: 'HAW 7/9/2018 17:28:37'!
or: aBlock1 or: aBlock2 or: aBlock3 or: aBlock4

	"I sending value to aBlock4 to optimize the generated byte-code - Hernan"
	^aBlock1 value or: [ aBlock2 value or: [ aBlock3 value or: [ aBlock4  value ]]].
! !


!True methodsFor: 'controlling' stamp: 'HAW 7/9/2018 17:29:32'!
and: aBlock1 and: aBlock2

	"I sending value to aBlock2 to optimize the generated byte-code - Hernan"
	^aBlock1 value and: [ aBlock2 value ]! !

!True methodsFor: 'controlling' stamp: 'HAW 7/9/2018 17:29:59'!
and: aBlock1 and: aBlock2 and: aBlock3

	"I sending value to aBlock3 to optimize the generated byte-code - Hernan"
	^aBlock1 value and: [ aBlock2 value and: [ aBlock3 value ]]! !

!True methodsFor: 'controlling' stamp: 'HAW 7/9/2018 17:30:40'!
and: aBlock1 and: aBlock2 and: aBlock3 and: aBlock4

	"I sending value to aBlock4 to optimize the generated byte-code - Hernan"
	^aBlock1 value and: [ aBlock2 value and: [ aBlock3 value and: [ aBlock4 value ]]] ! !

