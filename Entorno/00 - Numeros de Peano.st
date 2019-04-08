!classDefinition: #i category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #i
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'i class' category: #'00 - Numeros de Peano'!
i class
	instanceVariableNames: 'next'!

!i class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:38:05'!
* unNumeroDePeano

	^unNumeroDePeano! !

!i class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:12:40'!
+ unNumeroDePeano

	^unNumeroDePeano next! !

!i class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:20:44'!
/ unNumeroDePeano

	unNumeroDePeano = self ifTrue: [^self].
	self error: 'El uno no se puede dividir por un número diferente a sí mismo'.

! !

!i class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := ii.! !

!i class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 17:40:30'!
next

	^next! !


!classDefinition: #ii category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #ii
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ii class' category: #'00 - Numeros de Peano'!
ii class
	instanceVariableNames: 'next previous'!

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:39:57'!
* unNumeroDePeano

	"unNumeroDePeano = i ifTrue:[^self]."
	^unNumeroDePeano * self previous + unNumeroDePeano! !

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:03:00'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next.! !

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:34:21'!
- unNumeroDePeano
	unNumeroDePeano = i ifTrue:[^self previous].
	^self previous - unNumeroDePeano previous.! !

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:58:08'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue:[^i].
	^self - unNumeroDePeano / unNumeroDePeano + i.! !

!ii class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := iii.
	previous := i.! !

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:08:49'!
next

	next ifNil:
	[
		next _ self cloneNamed:(self name, 'i').
		next previous: self.
	].
^next! !

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:04:15'!
previous
	^previous! !

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:17:58'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!ii class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 18:11:15'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #iii category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #iii
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'iii class' category: #'00 - Numeros de Peano'!
iii class
	instanceVariableNames: 'next previous'!

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
* unNumeroDePeano

	"unNumeroDePeano = i ifTrue:[^self]."
	^unNumeroDePeano * self previous + unNumeroDePeano! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next.! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
- unNumeroDePeano
	unNumeroDePeano = i ifTrue:[^self previous].
	^self previous - unNumeroDePeano previous.! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue:[^i].
	^self - unNumeroDePeano / unNumeroDePeano + i.! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := iiii.
	previous := ii.! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
next

	next ifNil:
	[
		next _ self cloneNamed:(self name, 'i').
		next previous: self.
	].
^next! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
previous
	^previous! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!iii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #iiii category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #iiii
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'iiii class' category: #'00 - Numeros de Peano'!
iiii class
	instanceVariableNames: 'next previous'!

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
* unNumeroDePeano

	"unNumeroDePeano = i ifTrue:[^self]."
	^unNumeroDePeano * self previous + unNumeroDePeano! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next.! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
- unNumeroDePeano
	unNumeroDePeano = i ifTrue:[^self previous].
	^self previous - unNumeroDePeano previous.! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue:[^i].
	^self - unNumeroDePeano / unNumeroDePeano + i.! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:19'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := iiiii.
	previous := iii.! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
next

	next ifNil:
	[
		next _ self cloneNamed:(self name, 'i').
		next previous: self.
	].
^next! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
previous
	^previous! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!iiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:15:32'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #iiiii category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #iiiii
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'iiiii class' category: #'00 - Numeros de Peano'!
iiiii class
	instanceVariableNames: 'next previous'!

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
* unNumeroDePeano

	"unNumeroDePeano = i ifTrue:[^self]."
	^unNumeroDePeano * self previous + unNumeroDePeano! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next.! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
- unNumeroDePeano
	unNumeroDePeano = i ifTrue:[^self previous].
	^self previous - unNumeroDePeano previous.! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue:[^i].
	^self - unNumeroDePeano / unNumeroDePeano + i.! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := iiiiii.
	previous := iiii.! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
next

	next ifNil:
	[
		next _ self cloneNamed:(self name, 'i').
		next previous: self.
	].
^next! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous
	^previous! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!iiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #iiiiii category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #iiiiii
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'iiiiii class' category: #'00 - Numeros de Peano'!
iiiiii class
	instanceVariableNames: 'next previous'!

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
* unNumeroDePeano

	"unNumeroDePeano = i ifTrue:[^self]."
	^unNumeroDePeano * self previous + unNumeroDePeano! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next.! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
- unNumeroDePeano
	unNumeroDePeano = i ifTrue:[^self previous].
	^self previous - unNumeroDePeano previous.! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue:[^i].
	^self - unNumeroDePeano / unNumeroDePeano + i.! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := iiiiiii.
	previous := iiiii.! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
next

	next ifNil:
	[
		next _ self cloneNamed:(self name, 'i').
		next previous: self.
	].
^next! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous
	^previous! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!iiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #iiiiiii category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #iiiiiii
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'iiiiiii class' category: #'00 - Numeros de Peano'!
iiiiiii class
	instanceVariableNames: 'next previous'!

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
* unNumeroDePeano

	"unNumeroDePeano = i ifTrue:[^self]."
	^unNumeroDePeano * self previous + unNumeroDePeano! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next.! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
- unNumeroDePeano
	unNumeroDePeano = i ifTrue:[^self previous].
	^self previous - unNumeroDePeano previous.! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue:[^i].
	^self - unNumeroDePeano / unNumeroDePeano + i.! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := iiiiiiii.
	previous := iiiiii.! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
next

	next ifNil:
	[
		next _ self cloneNamed:(self name, 'i').
		next previous: self.
	].
^next! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous
	^previous! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!iiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !


!classDefinition: #iiiiiiii category: #'00 - Numeros de Peano'!
DenotativeObject subclass: #iiiiiiii
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '00 - Numeros de Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'iiiiiiii class' category: #'00 - Numeros de Peano'!
iiiiiiii class
	instanceVariableNames: 'next previous'!

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
* unNumeroDePeano

	"unNumeroDePeano = i ifTrue:[^self]."
	^unNumeroDePeano * self previous + unNumeroDePeano! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
+ unNumeroDePeano

	^self previous + unNumeroDePeano next.! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
- unNumeroDePeano
	unNumeroDePeano = i ifTrue:[^self previous].
	^self previous - unNumeroDePeano previous.! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
/ unNumeroDePeano
	
	self = unNumeroDePeano ifTrue:[^i].
	^self - unNumeroDePeano / unNumeroDePeano + i.! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/7/2019 21:37:20'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := iiiiiii.! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
next

	next ifNil:
	[
		next _ self cloneNamed:(self name, 'i').
		next previous: self.
	].
^next! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous
	^previous! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
previous: unNumeroDePeano
	previous := unNumeroDePeano.! !

!iiiiiiii class methodsFor: 'as yet unclassified' stamp: 'lf 4/2/2019 22:21:32'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]

! !

i initializeAfterFileIn!
ii initializeAfterFileIn!
iii initializeAfterFileIn!
iiii initializeAfterFileIn!
iiiii initializeAfterFileIn!
iiiiii initializeAfterFileIn!
iiiiiii initializeAfterFileIn!
iiiiiiii initializeAfterFileIn!