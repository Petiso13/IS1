!classDefinition: #TestsCart category: #'32-TusLibros'!
TestCase subclass: #TestsCart
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '32-TusLibros'!

!TestsCart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:41:47'!
test01CarritoSeCreaVacio

	| carrito dummyClientId catalog |

	catalog := OrderedCollection new.
	catalog add: 1.

	dummyClientId := 1.
	carrito := Cart with: dummyClientId and: catalog.

	self assert: carrito productList isEmpty. 	! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:47:48'!
test02SePuedeAgregarItemsAlCarrito

	| carrito dummyClientId dummyBookId catalog |

	
	dummyClientId := 1.
	dummyBookId := 42.
	
	catalog := OrderedCollection new.
	catalog add: dummyBookId.
	
	carrito := Cart with: dummyClientId and: catalog.

	Cart addTo: carrito book: dummyBookId amount: 123.

	self assert: (carrito productList at: dummyBookId) equals: 123. 	! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:51:49'!
test03NoSePuedeAgregarUnaCantidadInvalidaDeItemsAlCarrito

	| carrito dummyClientId dummyBookId catalog|
	
	dummyClientId := 1.
	dummyBookId := 42.
	
	catalog := OrderedCollection new.
	catalog add: dummyBookId.
		
	carrito := Cart with: dummyClientId and: catalog.

	self should: [Cart addTo: carrito book: dummyBookId amount: -1.]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemAmountErrorDescription ].	
	
! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:53:30'!
test04NoSePuedeAgregarUnNumeroNoNaturalDeItems

	| carrito dummyClientId dummyBookId catalog |
	
	dummyClientId := 1.
	dummyBookId := 42.
	
	catalog := OrderedCollection new.
	catalog add: dummyBookId.	
	carrito := Cart with: dummyClientId and: catalog.
	
	self should: [Cart addTo: carrito book: dummyBookId amount: 0.5.]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemAmountErrorDescription ].	
	
! !

!TestsCart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:56:08'!
test05NoSePuedeAgregarUnItemQueNoEsteDentroDelCatalogo

	| carrito dummyClientId dummyBookId invalidBookId catalog |
	
	dummyClientId := 1.
	dummyBookId := 42.
	invalidBookId := 250.
	
	catalog := OrderedCollection new.
	catalog add: dummyBookId.	
	carrito := Cart with: dummyClientId and: catalog.
	
	self should: [Cart addTo: carrito book: invalidBookId amount: 15.]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = Cart invalidItemIdErrorDescription ].	
	
! !


!classDefinition: #Cart category: #'32-TusLibros'!
Object subclass: #Cart
	instanceVariableNames: 'cartId clientId products catalog'
	classVariableNames: ''
	poolDictionaries: ''
	category: '32-TusLibros'!

!Cart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:58:28'!
catalog

	^catalog.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:37:49'!
initializeWith: aClientId and: aCatalog

	catalog := aCatalog.
	cartId := Cart getNextCartId.
	clientId := aClientId.
	products := Dictionary new.! !

!Cart methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:36:17'!
productList

	^products.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #'32-TusLibros'!
Cart class
	instanceVariableNames: 'lastCartId'!

!Cart class methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:59:58'!
addTo: cart book: isbn amount: amountOfCopies

	(cart catalog includes: isbn) ifFalse: [self error: Cart invalidItemIdErrorDescription ].	
	amountOfCopies isInteger ifFalse: [self error: Cart invalidItemAmountErrorDescription ].
	amountOfCopies > 0 ifFalse: [self error: Cart invalidItemAmountErrorDescription ].
	cart productList at: isbn put: amountOfCopies.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'lf 5/31/2019 21:22:08'!
getNextCartId

	lastCartId ifNil: [lastCartId := 0].
	lastCartId := lastCartId  + 1.
	^lastCartId.! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'lf 5/31/2019 21:59:34'!
invalidItemAmountErrorDescription
	
	^'The amount of items needs to be an integer value above 0'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:56:27'!
invalidItemIdErrorDescription
	
	^'This item is not in the catalog'! !

!Cart class methodsFor: 'as yet unclassified' stamp: 'lf 6/1/2019 20:37:08'!
with: aClientId and: aCatalog

	^self new initializeWith: aClientId and: aCatalog.! !
