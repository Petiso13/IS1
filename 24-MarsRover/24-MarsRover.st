!classDefinition: #RoverTest category: #'24-MarsRover'!
TestCase subclass: #RoverTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-MarsRover'!

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 19:25:28'!
test01RoverConoceOrientacionYPosicion
	
	| rover orientacionDefault posicionDefault|
	posicionDefault := 0@0.
	orientacionDefault := 'N'.
	rover := MarsRover new.
	self assert: rover posicion equals: posicionDefault.
	self assert: rover orientacion equals: orientacionDefault.! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 19:44:47'!
test02RoverReconoceInputVacio
	
	| rover orientacionDefault posicionDefault mensajeVacio|
	posicionDefault := 0@0.
	orientacionDefault := 'N'.
	mensajeVacio := ''.
	
	rover := MarsRover new.
	
	rover interpretar: mensajeVacio.
	
	self assert: rover posicion equals: posicionDefault.
	self assert: rover orientacion equals: orientacionDefault.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 19:54:37'!
test03RoverAvanzaCorrectamente
	
	| rover orientacionFinal posicionFinal mensaje|
	posicionFinal := 0@1.
	orientacionFinal := 'N'.
	mensaje := 'f'.
	
	rover := MarsRover new.
	
	rover interpretar: mensaje.
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 19:57:12'!
test04RoverRetrocedeCorrectamente
	
	| rover orientacionFinal posicionFinal mensaje|
	posicionFinal := 0@-1.
	orientacionFinal := 'N'.
	mensaje := 'b'.
	
	rover := MarsRover new.
	
	rover interpretar: mensaje.
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 20:29:59'!
test05RoverRotaCorrectamenteALaIzquierda
	
	| rover orientacionFinal posicionFinal mensaje|
	posicionFinal := 0@0.
	orientacionFinal := 'O'.
	mensaje := 'l'.
	
	rover := MarsRover new.
	
	rover interpretar: mensaje.
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 20:34:16'!
test06RoverRotaCorrectamenteALaDerecha
	
	| rover orientacionFinal posicionFinal mensaje|
	posicionFinal := 0@0.
	orientacionFinal := 'E'.
	mensaje := 'r'.
	
	rover := MarsRover new.
	
	rover interpretar: mensaje.
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 20:51:51'!
test07RoverAvanzaCorrectamenteLuegoDeRotarALaDerecha
	
	| rover orientacionFinal posicionFinal |
	posicionFinal := 1@0.
	orientacionFinal := 'E'.
	
	rover := MarsRover new.

	
	rover interpretar: 'r'.
	rover interpretar: 'f'.
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/12/2019 00:42:00'!
test08RoverRetrocedeCorrectamenteLuegoDeRotarALaIzquierda
	
	| rover orientacionFinal posicionFinal |
	posicionFinal := 1@0.
	orientacionFinal := 'O'.
	
	rover := MarsRover new.

	rover interpretar: 'l'.
	rover interpretar: 'b'.
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/12/2019 00:47:49'!
test09RoverInterpretaMultiplesComandosValidos
	
	| rover orientacionFinal posicionFinal comandos |
	
	posicionFinal := 0@2.
	orientacionFinal := 'N'.

	comandos := 'fflr'.
	
	rover := MarsRover new.

	rover interpretar: comandos.
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/12/2019 01:28:48'!
test10RoverInterrumpeEjecucionDeComandosAlRecibirComandoInvalido
	
	| rover orientacionFinal posicionFinal comandos |
	
	posicionFinal := 0@2.
	orientacionFinal := 'N'.

	comandos := 'fflrkflrrbf'.
	
	rover := MarsRover new.

	self
		should: [ rover interpretar: comandos. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = MarsRover descripcionDeErrorDeComandoInvalido ].	
	
	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !

!RoverTest methodsFor: 'as yet unclassified' stamp: 'lf 5/12/2019 20:27:12'!
test11RoverIgnoraEspaciosEnLaListaDeComandos
	
	| rover orientacionFinal posicionFinal comandos |
	
	posicionFinal := 0@2.
	orientacionFinal := 'N'.

	comandos := 'f f l r'.
	
	rover := MarsRover new.
	rover interpretar: comandos.

	self assert: rover posicion equals: posicionFinal.
	self assert: rover orientacion equals: orientacionFinal.
	
	! !


!classDefinition: #MarsRover category: #'24-MarsRover'!
Object subclass: #MarsRover
	instanceVariableNames: 'posicion orientacion'
	classVariableNames: ''
	poolDictionaries: ''
	category: '24-MarsRover'!

!MarsRover methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 19:24:53'!
initialize

	orientacion := 'N'.
	posicion := 0@0.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 19:28:16'!
orientacion

	^orientacion.! !

!MarsRover methodsFor: 'as yet unclassified' stamp: 'lf 5/6/2019 19:28:06'!
posicion

	^posicion.! !


!MarsRover methodsFor: 'Comportamiento' stamp: 'lf 5/12/2019 01:23:49'!
interpretar: mensajeAInterpretar 

	mensajeAInterpretar do: [:comando | 
		self revisarQueElComandoSeaValido: comando.
		self rotarOrientacion: comando.
		self moverRover: comando.
	].! !

!MarsRover methodsFor: 'Comportamiento' stamp: 'lf 5/12/2019 00:57:47'!
moverRover: direccionAAvanzar

	| switch |
		
	switch _ Dictionary new.
	switch at: 'N' put: 0@1.
	switch at: 'E' put: 1@0.
	switch at: 'S' put: 0@-1.
	switch at: 'O' put: -1@0.

	direccionAAvanzar = $f ifTrue: [posicion := posicion + (switch at: orientacion)].
	direccionAAvanzar = $b ifTrue: [posicion := posicion - (switch at: orientacion)].! !

!MarsRover methodsFor: 'Comportamiento' stamp: 'lf 5/12/2019 01:25:07'!
revisarQueElComandoSeaValido: comando

	| esComandoValido | 

	esComandoValido := #($  $f $b $l $r) includes: comando.
	esComandoValido ifFalse: [self error: MarsRover descripcionDeErrorDeComandoInvalido]
 
! !

!MarsRover methodsFor: 'Comportamiento' stamp: 'lf 5/12/2019 00:58:07'!
rotarOrientacion: direccionARotar

	| switch |
		
	switch _ Dictionary new.
	switch at: 'N' put: #('O' 'E').
	switch at: 'E' put: #('N' 'S').
	switch at: 'S' put: #('E' 'O').
	switch at: 'O' put: #('S' 'N').
	
	direccionARotar = $l ifTrue:[orientacion := (switch at: orientacion) at: 1].
	direccionARotar = $r ifTrue:[orientacion := (switch at: orientacion) at: 2].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MarsRover class' category: #'24-MarsRover'!
MarsRover class
	instanceVariableNames: ''!

!MarsRover class methodsFor: 'as yet unclassified' stamp: 'lf 5/12/2019 01:04:14'!
descripcionDeErrorDeComandoInvalido

	^'Comando invalido'! !
