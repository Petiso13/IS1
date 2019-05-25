!classDefinition: #TerniLapilliTest category: #'IS1-Tateti'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Tateti'!

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test01TableroSeEncuentraVacioInicialmente

	| juego tablero |
	juego:= TerniLapilli new.
	tablero := juego tablero.
	
	self assert: tablero isEmpty.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test02SePuedeColocarUnaPiezaEnElTablero

	| juego tablero |
	juego:= TerniLapilli new.
	tablero := juego tablero.
	
	self assert: tablero isEmpty.
	
	juego colocarPieza: 'X' en: 1@1.
	
	tablero := juego tablero.
	
	self assert: (tablero at: 1@1) equals: 'X'.! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:06'!
test03NoSePuedenPisarPiezasEnElTablero

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
		
	self
		should: [ juego colocarPieza: 'O' en: 1@1. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDePosicionOcupada ].	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test04NoSePuedenColocarDosPiezasDelMismoTipoSeguidas

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	
	self
		should: [ juego colocarPieza: 'X' en: 2@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDePiezaRepetida ].	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test05SoloSePuedenPonerPiezasValidas

	| juego |
	juego:= TerniLapilli new.

	self
		should: [ juego colocarPieza: 'J' en: 2@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDePiezaInvalida ].	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test06NoSePuedenColocarMasDeTresPiezasDelMismoTipo

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 1@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 2@1.
	juego colocarPieza: 'X' en: 2@2.
	juego colocarPieza: 'O' en: 3@1.
	
	self
		should: [ juego colocarPieza: 'X' en: 2@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDeCantidadMaximaDePiezasSuperada ].	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:06'!
test07NoSePuedenColocarPiezasFueraDelTablero

	| juego |
	juego:= TerniLapilli new.
	
	self
		should: [ juego colocarPieza: 'X' en: 2@5. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDePosicionInvalida ].	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:06'!
test08NoSePuedeDeslizarPiezasSiNoEstanTodasColocadas

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 1@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 3@2.

	self
		should: [ juego moverDesde: 3@1 hasta: 2@2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionNoSePuedenMoverPiezas ].	
	! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test09LasPiezasSeMuevenAPosicionesValidas

	| juego tablero |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 1@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 3@2.
	juego colocarPieza: 'O' en: 3@3.

	juego moverDesde: 3@2 hasta: 2@2. 
	
	tablero := juego tablero.
	
	self assert: (tablero at: 2@2) equals: 'X'.
	self deny: (tablero includesKey: 3@2).! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test10NoSePuedeMoverUnaPiezaEncimaDeOtra

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 1@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 3@2.
	juego colocarPieza: 'O' en: 3@3.

	self
		should: [ juego moverDesde: 3@2 hasta: 3@1. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDePosicionOcupada ].	
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test11NoSePuedeMoverUnaPiezaFueraDelTablero

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 1@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 3@2.
	juego colocarPieza: 'O' en: 3@3.

	self
		should: [ juego moverDesde: 3@2 hasta: 4@2. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDePosicionInvalida ].	
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test12NoSePuedeMoverUnaPiezaSobreUnaDiagonalInvalida

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 1@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 3@2.
	juego colocarPieza: 'O' en: 3@3.

	self
		should: [ juego moverDesde: 3@2 hasta: 2@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDeMovimientoInvalido ].	
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test13ElJuegoInformaLaVictoriaAlColocarPieza

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 1@2.
	juego colocarPieza: 'O' en: 3@2.
	
	self
		should: [ juego colocarPieza: 'X' en: 1@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDeVictoriaX ].	
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test14ElJuegoInformaLaVictoriaAlMoverPieza

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 2@2.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 1@2.
	juego colocarPieza: 'O' en: 3@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 2@3.
	
	self
		should: [ juego moverDesde: 2@2 hasta: 1@1. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionDeVictoriaX ].	
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test15NoEsPosibleColocarPiezaLuegoDeTerminarPartida

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 1@1.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 1@2.
	juego colocarPieza: 'O' en: 3@2.
	
	self should: [juego colocarPieza: 'X' en: 1@3.] raise: Error.
	
	self
		should: [ juego colocarPieza: 'O' en: 3@3. ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionPartidaTerminada ].	
! !

!TerniLapilliTest methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 20:06:07'!
test16NoEsPosibleMoverPiezaLuegoDeTerminarPartida

	| juego |
	juego:= TerniLapilli new.
	juego colocarPieza: 'X' en: 2@2.
	juego colocarPieza: 'O' en: 3@1.
	juego colocarPieza: 'X' en: 1@2.
	juego colocarPieza: 'O' en: 3@2.
	juego colocarPieza: 'X' en: 1@3.
	juego colocarPieza: 'O' en: 2@3.

	self should: [ juego moverDesde: 2@2 hasta: 1@1. ] raise: Error.
	
	self
		should: [ juego moverDesde: 2@3 hasta: 2@2 ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = TerniLapilli descripcionPartidaTerminada ].	
! !


!classDefinition: #TerniLapilli category: #'IS1-Tateti'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'tablero ultimaPiezaJugada dimensionesDelTablero'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1-Tateti'!

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:42:45'!
comprobarEsTurnoDe: pieza

	(pieza = 'X' or: pieza = 'O') ifFalse: [self error: TerniLapilli descripcionDePiezaInvalida ].
	(pieza = ultimaPiezaJugada) ifTrue:[self error: TerniLapilli descripcionDePiezaRepetida ].! !

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:43:07'!
comprobarMenosDeTresPiezasDeTipo: pieza

	| piezasDelMismoTipo |
	piezasDelMismoTipo := tablero select: [:a | a = pieza].
	(piezasDelMismoTipo size = 3) ifTrue: [self error: TerniLapilli descripcionDeCantidadMaximaDePiezasSuperada ].
! !

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:36:19'!
comprobarMovimientoEsValidoDesde: origen hasta: destino

	| cambioEnLaPosicion esMovimientoValido|
	self comprobarPosicionDentroDelTablero: destino.
	cambioEnLaPosicion := destino - origen.
	esMovimientoValido := cambioEnLaPosicion x = 0.
	esMovimientoValido := esMovimientoValido or: cambioEnLaPosicion y = 0.
	esMovimientoValido := esMovimientoValido or: destino = (2@2).
	esMovimientoValido := esMovimientoValido or: origen = (2@2).
	
	esMovimientoValido ifFalse: [self error: TerniLapilli descripcionDeMovimientoInvalido ].! !

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:34:36'!
comprobarPartidaGanadaPorJugador: pieza

	| piezas victoria |
	
	piezas := tablero select: [:a | a = pieza].
	piezas := piezas keys asSet.
	victoria := self lineasDelTablero includes: piezas.
	^victoria.! !

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:34:11'!
comprobarPartidaTerminada

	| terminoLaPartida |
	terminoLaPartida := (self comprobarPartidaGanadaPorJugador: 'O') or: (self comprobarPartidaGanadaPorJugador: 'X').
	terminoLaPartida ifTrue: [self error: TerniLapilli descripcionPartidaTerminada ].
	
! !

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:36:19'!
comprobarPosicionDentroDelTablero: posicion

	| esPosicionValida |
	esPosicionValida := true.
	esPosicionValida  := esPosicionValida and: (posicion x <= dimensionesDelTablero x).
	esPosicionValida  := esPosicionValida and: (posicion x >= 1).
	esPosicionValida  := esPosicionValida and: (posicion y <= dimensionesDelTablero y).
	esPosicionValida  := esPosicionValida and: (posicion y >= 1).
	
	esPosicionValida ifFalse: [self error: TerniLapilli descripcionDePosicionInvalida ].
	! !

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:37:14'!
comprobarTodasLasPiezasFueronColocadas

	| piezasColocadas |
	piezasColocadas := tablero select: [:a | a = 'X' or: a = 'O'].
	(piezasColocadas size = 6) ifFalse: [self error: TerniLapilli descripcionNoSePuedenMoverPiezas ].
! !

!TerniLapilli methodsFor: 'comprobaciones' stamp: 'lf 5/25/2019 00:34:11'!
comprobarVictoria

	(self comprobarPartidaGanadaPorJugador: 'X') ifTrue: [self error: TerniLapilli descripcionDeVictoriaX ].
	(self comprobarPartidaGanadaPorJugador: 'O') ifTrue: [self error: TerniLapilli descripcionDeVictoriaO ].

	
! !


!TerniLapilli methodsFor: 'accionesDeJuego' stamp: 'lf 5/25/2019 00:43:07'!
colocarPieza: pieza en: posicion

	self comprobarPartidaTerminada.
	self comprobarPosicionDentroDelTablero: posicion.
	self comprobarEsTurnoDe: pieza.
	self comprobarMenosDeTresPiezasDeTipo: pieza.
	(tablero includesKey: posicion) ifTrue: [self error: TerniLapilli descripcionDePosicionOcupada ].
	tablero at: posicion put: pieza.
	ultimaPiezaJugada := pieza.
	self comprobarVictoria! !

!TerniLapilli methodsFor: 'accionesDeJuego' stamp: 'lf 5/25/2019 00:42:45'!
moverDesde: origen hasta: destino

	| pieza | 
	pieza := tablero at: origen.
	self comprobarPartidaTerminada.
	self comprobarMovimientoEsValidoDesde: origen hasta: destino. 
	self comprobarEsTurnoDe: pieza.
	self comprobarTodasLasPiezasFueronColocadas.
	(tablero includesKey: destino) ifTrue: [self error: TerniLapilli descripcionDePosicionOcupada ].
	tablero at: destino put: pieza.
	tablero removeKey: origen.
	ultimaPiezaJugada := pieza.
	self comprobarVictoria.
! !


!TerniLapilli methodsFor: 'tablero' stamp: 'lf 5/25/2019 00:25:30'!
lineasDelTablero

	| lineas |
	
	lineas := Set new.
	
	"Filas"
	lineas add: (Set with: 1@1 with: 1@2 with: 1@3).
	lineas add: (Set with: 2@1 with: 2@2 with: 2@3).
	lineas add: (Set with: 3@1 with: 3@2 with: 3@3).
	
	"Diagonales"
	lineas add: (Set with: 1@1 with: 2@2 with: 3@3).
	lineas add: (Set with: 1@3 with: 2@2 with: 3@1).
	
	"Columnas"
	lineas add: (Set with: 1@1 with: 2@1 with: 3@1).
	lineas add: (Set with: 1@2 with: 2@2 with: 3@2).
	lineas add: (Set with: 1@3 with: 2@3 with: 3@3).
	
	^lineas.! !

!TerniLapilli methodsFor: 'tablero' stamp: 'lf 5/20/2019 17:41:52'!
tablero

	^tablero.! !


!TerniLapilli methodsFor: 'inicializacion' stamp: 'lf 5/20/2019 18:34:31'!
initialize

	tablero := Dictionary new.
	dimensionesDelTablero := 3@3.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'IS1-Tateti'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'nil' stamp: 'lf 5/20/2019 17:55:03'!
descripcionDePosicionOcupada

	^'Esta posición del tablero se encuentra ocupada por otra pieza'! !


!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/20/2019 18:01:30'!
descripcionDeCantidadMaximaDePiezasSuperada

	^'El tablero ya contiene la máxima cantidad de piezas de este tipo'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/20/2019 19:22:52'!
descripcionDeMovimientoInvalido

	^'El movimiento no es válido'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/20/2019 18:24:18'!
descripcionDePiezaInvalida

	^'La pieza proveida no es de un tipo válido'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/20/2019 18:24:02'!
descripcionDePiezaRepetida

	^'No se puede jugar el mismo tipo de pieza dos veces seguidas'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/20/2019 18:33:26'!
descripcionDePosicionInvalida

	^'La posicion proporcionada no es una posición válida de este tablero.'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 19:29:16'!
descripcionDeVictoriaO

	^'Felicitaciones. El jugador O ganó la partida'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/23/2019 19:29:10'!
descripcionDeVictoriaX

	^'Felicitaciones. El jugador X ganó la partida'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/20/2019 19:00:21'!
descripcionNoSePuedenMoverPiezas

	^'No se pueden mover piezas hasta tener todas colocadas en el mismo'! !

!TerniLapilli class methodsFor: 'as yet unclassified' stamp: 'lf 5/20/2019 20:11:11'!
descripcionPartidaTerminada

	^'La partida ya finalizó'! !
