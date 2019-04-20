!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:17:30'!
test01SearchForValidPrefixInEmptyStackReturnsNotFoundMessage! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:10:45'!
test02CannotSearchForEmptyPrefix! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:11:06'!
test03CannotSearchForPrefixWithASpace! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:15:39'!
test04SearchWithNoHitsReturnsNotFoundMessage! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:14:15'!
test05SearchWithNoHitsDoesntModifyStack! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:19:47'!
test06SearchWithOneHitReturnsSentence! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:20:26'!
test07SearchWithOneHitDoesntModifyStack! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:22:39'!
test08SearchWithMultipleHitsReturnsAllSentences! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:21:29'!
test09SearchWithMultipleHitsDoesntModifyStack! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:24:39'!
test10SearchIsCaseSensitive! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 03:47:41'!
test11SentencesBeginningWithSpacesAreAlsoHits! !


!classDefinition: #ElementoDelStack category: #'Stack-Exercise'!
Object subclass: #ElementoDelStack
	instanceVariableNames: 'stackContenedor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoDelStack methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 01:50:33'!
initializeWith: aStack

	stackContenedor := aStack.! !

!ElementoDelStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:26:19'!
removerDelStack

	self subclassResponsibility ! !

!ElementoDelStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:26:09'!
valorDelElemento

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ElementoDelStack class' category: #'Stack-Exercise'!
ElementoDelStack class
	instanceVariableNames: ''!

!ElementoDelStack class methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:33:52'!
with: aStack 
	
	^self new initializeWith: aStack.! !


!classDefinition: #ElementoDelStackConContenido category: #'Stack-Exercise'!
ElementoDelStack subclass: #ElementoDelStackConContenido
	instanceVariableNames: 'contenido'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoDelStackConContenido methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:22:14'!
asignarContenido: contenidoAAsignar

	contenido := contenidoAAsignar.! !

!ElementoDelStackConContenido methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 02:06:00'!
removerDelStack

	stackContenedor removeLast.
	^contenido! !

!ElementoDelStackConContenido methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:26:45'!
valorDelElemento

	^contenido.! !


!classDefinition: #ElementoDelStackVacio category: #'Stack-Exercise'!
ElementoDelStack subclass: #ElementoDelStackVacio
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!ElementoDelStackVacio methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:37:05'!
removerDelStack

	self error: OOStack stackEmptyErrorDescription.! !

!ElementoDelStackVacio methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:37:16'!
valorDelElemento

	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'coleccion'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:39:12'!
initialize

	coleccion := OrderedCollection new.
	coleccion addLast: (ElementoDelStackVacio with: coleccion).! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:32:15'!
isEmpty

	^coleccion size =1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:29:57'!
pop
	|valorDelElementoARemover|
	valorDelElementoARemover := self top.
	coleccion last removerDelStack.
	^valorDelElementoARemover.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:39:37'!
push: object

	|ElementoAAgregar|
	ElementoAAgregar := ElementoDelStackConContenido with: coleccion.
	ElementoAAgregar asignarContenido: object.
	coleccion addLast: ElementoAAgregar.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:30:12'!
size

	 ^coleccion size - 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:25:34'!
top

	^coleccion last valorDelElemento.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: 'coleccion'!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackDondeBuscar'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 02:26:16'!
find: prefijoDeOracionesABuscar

	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 02:18:31'!
initializeWith: aStack

	stackDondeBuscar := aStack. ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 02:16:54'!
with: aStack

	^self new initializeWith: aStack. 

 ! !
