!classDefinition: #LuzAmarilla category: #Semaforo!
DenotativeObjectMorph subclass: #LuzAmarilla
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzAmarilla class' category: #Semaforo!
LuzAmarilla class
	instanceVariableNames: ''!

!LuzAmarilla class methodsFor: 'morph' stamp: 'LF 3/25/2019 20:24:53'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzAmarilla class methodsFor: 'cambiarEstado' stamp: 'LF 3/25/2019 20:49:52'!
apagar
	
	LuzAmarilla color: Color black.
	(Delay for: 1*second) wait.
	! !

!LuzAmarilla class methodsFor: 'cambiarEstado' stamp: 'LF 3/25/2019 20:50:08'!
prender
	
	LuzAmarilla color: Color yellow.
	(Delay for: 1*second) wait.
	! !


!LuzAmarilla class methodsFor: 'comportamiento' stamp: 'LF 3/25/2019 20:50:44'!
alternar

	LuzAmarilla prender.
	LuzAmarilla apagar.! !


!LuzAmarilla class methodsFor: 'as yet unclassified' stamp: 'LF 3/25/2019 21:02:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #LuzRoja category: #Semaforo!
DenotativeObjectMorph subclass: #LuzRoja
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzRoja class' category: #Semaforo!
LuzRoja class
	instanceVariableNames: ''!

!LuzRoja class methodsFor: 'morph' stamp: 'LF 3/25/2019 20:24:32'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzRoja class methodsFor: 'as yet unclassified' stamp: 'LF 3/25/2019 21:02:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #LuzVerde category: #Semaforo!
DenotativeObjectMorph subclass: #LuzVerde
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzVerde class' category: #Semaforo!
LuzVerde class
	instanceVariableNames: ''!

!LuzVerde class methodsFor: 'morph' stamp: 'LF 3/25/2019 20:24:46'!
createMorph

	^EllipseMorph new
		color: Color black;
		yourself! !


!LuzVerde class methodsFor: 'as yet unclassified' stamp: 'LF 3/25/2019 21:02:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #Semaforo category: #Semaforo!
DenotativeObjectMorph subclass: #Semaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Semaforo class' category: #Semaforo!
Semaforo class
	instanceVariableNames: ''!

!Semaforo class methodsFor: 'morph' stamp: 'LF 3/25/2019 20:23:58'!
createMorph

	^LayoutMorph newColumn
		morphExtent: 60 @ 130;
		yourself
! !


!Semaforo class methodsFor: 'cambiarEstado' stamp: 'LF 3/25/2019 20:29:51'!
apagar

	LuzRoja color: Color black.
	LuzAmarilla color: Color black.
	LuzVerde color: Color black.! !

!Semaforo class methodsFor: 'cambiarEstado' stamp: 'LF 3/25/2019 20:53:35'!
prender


	LuzAmarilla alternar.
	LuzAmarilla alternar.
	LuzAmarilla alternar.
	LuzAmarilla alternar.
	LuzAmarilla alternar.

	LuzRoja color: Color red.
	LuzAmarilla color: Color yellow.
	LuzVerde color: Color green.! !


!Semaforo class methodsFor: 'as yet unclassified' stamp: 'LF 3/25/2019 21:02:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !

LuzAmarilla initializeAfterFileIn!
LuzRoja initializeAfterFileIn!
LuzVerde initializeAfterFileIn!
Semaforo initializeAfterFileIn!