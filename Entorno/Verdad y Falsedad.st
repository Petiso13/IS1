!classDefinition: #Falso category: #'Verdad y Falsedad'!
DenotativeObject subclass: #Falso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Verdad y Falsedad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Falso class' category: #'Verdad y Falsedad'!
Falso class
	instanceVariableNames: ''!

!Falso class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:18:08'!
negar
	^Verdadero! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:31:04'!
o: unBooleano
	^unBooleano! !

!Falso class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:30:41'!
y: unBooleano
	^Falso! !


!classDefinition: #Verdadero category: #'Verdad y Falsedad'!
DenotativeObject subclass: #Verdadero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Verdad y Falsedad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Verdadero class' category: #'Verdad y Falsedad'!
Verdadero class
	instanceVariableNames: ''!

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:18:19'!
negar
	^Falso! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:30:28'!
o: unBooleano
	^Verdadero! !

!Verdadero class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:31:18'!
y: unBooleano
	^unBooleano! !


!classDefinition: #ZTestsBooleanos category: #'Verdad y Falsedad'!
DenotativeObject subclass: #ZTestsBooleanos
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Verdad y Falsedad'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ZTestsBooleanos class' category: #'Verdad y Falsedad'!
ZTestsBooleanos class
	instanceVariableNames: ''!

!ZTestsBooleanos class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:54:43'!
CorrerTests

	self T01VerdaderoNegadoEsFalso.
	self T02FalsoNegadoEsVerdadero.
	self T03VerdaderoYBoolEsBool.
	self T04FalsoYBoolEsFalso.
	self T05VerdaderoOBoolEsVerdadero.
	self T06FalsoOBoolEsFalso.
	
	"Ver que esta corriendo todo"
	"Assert that: (Falso negar) isEqualTo: Falso."! !

!ZTestsBooleanos class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:48:13'!
T01VerdaderoNegadoEsFalso

	Assert that: (Verdadero negar) isEqualTo: Falso.
	! !

!ZTestsBooleanos class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:48:22'!
T02FalsoNegadoEsVerdadero

	Assert that: (Falso negar) isEqualTo: Verdadero.
	! !

!ZTestsBooleanos class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:48:33'!
T03VerdaderoYBoolEsBool
	
	Assert that: (Verdadero y: Verdadero) isEqualTo: Verdadero.
	Assert that: (Verdadero y: Falso) isEqualTo: Falso.! !

!ZTestsBooleanos class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:49:56'!
T04FalsoYBoolEsFalso

	Assert that: (Falso y: Verdadero) isEqualTo: Falso.
	Assert that: (Falso y: Falso) isEqualTo: Falso.! !

!ZTestsBooleanos class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:49:19'!
T05VerdaderoOBoolEsVerdadero

	Assert that: (Verdadero o: Verdadero) isEqualTo: Verdadero.
	Assert that: (Verdadero o: Falso) isEqualTo: Verdadero.! !

!ZTestsBooleanos class methodsFor: 'as yet unclassified' stamp: 'LF 3/28/2019 20:49:41'!
T06FalsoOBoolEsFalso

	Assert that: (Falso o: Verdadero) isEqualTo: Verdadero.
	Assert that: (Falso o: Falso) isEqualTo: Falso.! !


!classDefinition: #anObject category: #'Verdad y Falsedad'!
DenotativeObject subclass: #anObject
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Verdad y Falsedad'!
