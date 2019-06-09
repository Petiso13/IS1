!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'lf 6/9/2019 19:59:22'!
defaultCatalog
	
	| catalog |
	
	catalog := Dictionary new.
	catalog at: self itemSellByTheStore put: 11.
	
	^catalog.! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'support' stamp: 'lf 6/9/2019 18:12:55'!
createCard
	
| cardNumber name yearNumber monthNumber expirationMonthOfYear |
	
	yearNumber := Year current yearNumber + 5.
	monthNumber := Month current monthIndex.
	expirationMonthOfYear := GregorianMonthOfYear yearNumber: yearNumber monthNumber: monthNumber.
	
	name := 'John Doe'.
	cardNumber := '1234567890123456'.
	^CreditCard createWith: cardNumber and: expirationMonthOfYear and: name. ! !

!CashierTest methodsFor: 'support' stamp: 'ic 6/9/2019 03:21:55'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'lf 6/9/2019 18:09:58'!
createExpiredCard
	
	| cardNumber name yearNumber monthNumber expirationMonthOfYear |
	
	yearNumber := Year current yearNumber - 1.
	monthNumber := Month current monthIndex.
	expirationMonthOfYear := GregorianMonthOfYear yearNumber: yearNumber monthNumber: monthNumber.
	
	name := 'John Doe'.
	cardNumber := '1234567890123456'.
	^CreditCard createWith: cardNumber and: expirationMonthOfYear and: name. ! !

!CashierTest methodsFor: 'support' stamp: 'lf 6/9/2019 19:31:41'!
createInvalidCard
	
	| cardNumber name yearNumber monthNumber expirationMonthOfYear |
	
	yearNumber := Year current yearNumber + 5.
	monthNumber := Month current monthIndex.
	expirationMonthOfYear := GregorianMonthOfYear yearNumber: yearNumber monthNumber: monthNumber.
	
	name := 'John Doe'.
	cardNumber := '12345678901234'.
	^CreditCard createWith: cardNumber and: expirationMonthOfYear and: name. ! !

!CashierTest methodsFor: 'support' stamp: 'lf 6/9/2019 19:37:49'!
createInvalidCardWithLongName
	
	| cardNumber name yearNumber monthNumber expirationMonthOfYear |
	
	yearNumber := Year current yearNumber + 5.
	monthNumber := Month current monthIndex.
	expirationMonthOfYear := GregorianMonthOfYear yearNumber: yearNumber monthNumber: monthNumber.
	
	name := 'John Doe abcdefghijkmnlopqrstuvwxyz'.
	cardNumber := '1234567890123456'.
	^CreditCard createWith: cardNumber and: expirationMonthOfYear and: name. ! !

!CashierTest methodsFor: 'support' stamp: 'lf 6/9/2019 19:59:48'!
defaultCatalog
	
	| catalog | 
	catalog := Dictionary new.
	catalog at: self itemSoldByTheStore put: 11.
	
	^ catalog.! !

!CashierTest methodsFor: 'support' stamp: 'ic 6/9/2019 03:25:02'!
itemNotSoldByTheStore
	
	^'invalidBook'! !

!CashierTest methodsFor: 'support' stamp: 'ic 6/9/2019 03:26:21'!
itemSoldByTheStore
	
	^ 'validBook'! !


!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 18:23:24'!
test01CheckoutOfEmptyCartThrowsException

	| cashier card merchantProcessor |
	
	merchantProcessor := SimulatedMerchantProcessor new.
	cashier := Cashier with: merchantProcessor.
	card := self createCard.
	
	self should: [cashier checkout: self createCart with: card ]
		 raise: Error 
		 withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier emptyCartErrorMessage.].
	 ! !

!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 19:23:56'!
test02CashierBouncesExpiredCards

	| cashier cart card merchantProcessor |
	
	merchantProcessor := SimulatedMerchantProcessor new.	
	cashier := Cashier with: merchantProcessor.
	card := self createExpiredCard.
	
	cart := self createCart.
	cart add: self itemSoldByTheStore.
	
	self should: [cashier checkout: cart with: card ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier expiredCardErrorMessage ].
! !

!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 19:33:23'!
test03MerchantProcessorBouncesInvalidCards

	| cashier cart card merchantProcessor |
	
	card := self createCard.

	merchantProcessor := SimulatedMerchantProcessor new.
	merchantProcessor flagAsInvalid: card.	
	cashier := Cashier with: merchantProcessor.

	cart := self createCart.
	cart add: self itemSoldByTheStore.
	
	self should: [cashier checkout: cart with: card ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcessorResponses invalidCardMessage ].
! !

!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 19:33:32'!
test04MerchantProcessorBouncesStolenCards

	| cashier cart card merchantProcessor |
	
	card := self createCard.

	merchantProcessor := SimulatedMerchantProcessor new.
	merchantProcessor flagAsStolen: card.	
	cashier := Cashier with: merchantProcessor.

	cart := self createCart.
	cart add: self itemSoldByTheStore.
	
	self should: [cashier checkout: cart with: card ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = MerchantProcessorResponses stolenCardMessage].
! !

!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 19:34:09'!
test05CashierBouncesInvalidCardNumber

	| cashier cart card merchantProcessor |
	
	merchantProcessor := SimulatedMerchantProcessor new.
	cashier := Cashier with: merchantProcessor.
	card := self createInvalidCard.
	
	cart := self createCart.
	cart add: self itemSoldByTheStore.
	
	self should: [cashier checkout: cart with: card ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier invalidCardNumberErrorMessage ].
! !

!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 19:38:08'!
test06CashierBouncesCardsWithNamesTooLong

	| cashier cart card merchantProcessor |
	
	merchantProcessor := SimulatedMerchantProcessor new.
	cashier := Cashier with: merchantProcessor.
	card := self createInvalidCardWithLongName .
	
	cart := self createCart.
	cart add: self itemSoldByTheStore.
	
	self should: [cashier checkout: cart with: card ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier InvalidCardNameErrorMessage ].
! !

!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 20:23:53'!
test07CashierCalculatesTotalCorrectly

	| catalog cashier cart merchantProcessor |
	
	catalog := Dictionary new.
	catalog at: self itemSoldByTheStore put: 150.
		
	cart := Cart acceptingItemsOf: catalog.
	cart add: 2 of: self itemSoldByTheStore.
	
	
	merchantProcessor := SimulatedMerchantProcessor new.
	cashier := Cashier with: merchantProcessor.
	
	self assert: (cashier calculateTotal: cart) equals: 300.! !

!CashierTest methodsFor: 'tests' stamp: 'lf 6/9/2019 20:39:48'!
test08CashierStopsIfTotalIsTooLarge

	| catalog cashier cart merchantProcessor card |
	
	catalog := Dictionary new.
	catalog at: self itemSoldByTheStore put: 100000000000000000000.
		
	cart := Cart acceptingItemsOf: catalog.
	cart add: 2 of: self itemSoldByTheStore.
	card := self createCard.
	
	merchantProcessor := SimulatedMerchantProcessor new.
	cashier := Cashier with: merchantProcessor.

	self should: [cashier checkout: cart with: card ]
	raise: Error 
	withExceptionDo: [ :anError |
		self assert: anError messageText = Cashier totalTooBigErrorDescription ].
! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'lf 6/9/2019 19:57:03'!
assertIsValidItem: anItem

	(catalog keys includes: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'lf 6/9/2019 20:07:51'!
catalog
	
	^catalog ! !

!Cart methodsFor: 'queries' stamp: 'lf 6/9/2019 20:07:36'!
items
	
	^items ! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'merchantProcessor'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 20:24:43'!
calculateTotal: aCart

	| result |
	result := 0.
	aCart items do: [:anItem | result := result + aCart catalog at: anItem].	
	^result.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 20:34:50'!
checkout: aCart with: aCreditCard

	| result amount |
	
	self validateBeforeProcessing: aCreditCard.
	aCart isEmpty ifTrue: [self error: Cashier emptyCartErrorMessage ].
	amount := self calculateTotal: aCart. 
	amount truncated asString size > 15 ifTrue: [self error: Cashier totalTooBigErrorDescription].

	result := merchantProcessor checkout: aCreditCard amount: amount.
	result first = $0 ifFalse: [^self error: result].

	! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 18:16:24'!
initializeWith: aMerchantProcessor

	merchantProcessor := aMerchantProcessor.! !

!Cashier methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 19:39:03'!
validateBeforeProcessing: aCreditCard
	
	aCreditCard expiration < GregorianMonthOfYear current ifTrue: [self error: Cashier expiredCardErrorMessage ].
	
	aCreditCard number size = 16 ifFalse: [self error: Cashier invalidCardNumberErrorMessage ].
	aCreditCard name size <= 30 ifFalse: [self error: Cashier InvalidCardNameErrorMessage ].
	aCreditCard name size > 0 ifFalse: [self error: Cashier InvalidCardNameErrorMessage ].! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error messages' stamp: 'lf 6/9/2019 18:56:44'!
InvalidCardNameErrorMessage
	
	^'Invalid card name.'! !

!Cashier class methodsFor: 'error messages' stamp: 'ic 6/9/2019 03:45:56'!
emptyCartErrorMessage
	
	^'Your cart is empty.'! !

!Cashier class methodsFor: 'error messages' stamp: 'lf 6/9/2019 17:41:29'!
expiredCardErrorMessage
	
	^'The card provided has expired.'! !

!Cashier class methodsFor: 'error messages' stamp: 'lf 6/9/2019 18:55:22'!
invalidCardNumberErrorMessage
	
	^'Invalid card number.'! !

!Cashier class methodsFor: 'error messages' stamp: 'lf 6/9/2019 19:05:50'!
stolenCardErrorMessage
	
	^'The card provided is flaged as stolen.'! !

!Cashier class methodsFor: 'error messages' stamp: 'lf 6/9/2019 20:38:10'!
totalTooBigErrorDescription
	
	^'Transaction total is too high'! !

!Cashier class methodsFor: 'error messages' stamp: 'lf 6/9/2019 18:17:01'!
with: aMerchantProcessor
	
	^self new initializeWith: aMerchantProcessor.! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expirationMonth name'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 17:05:33'!
expiration

	^expirationMonth.
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 17:03:53'!
initializeWith: aNumber and: aMonthOfYear and: aName 

	number := aNumber.
	expirationMonth := aMonthOfYear.
	name := aName.! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 17:05:16'!
name

	^name.
! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 17:05:11'!
number

	^number.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 17:04:26'!
createWith: aNumber and: aMonthOfYear and: aName 

	^self new initializeWith: aNumber and: aMonthOfYear and: aName.! !


!classDefinition: #MerchantProcessorResponses category: #TusLibros!
Object subclass: #MerchantProcessorResponses
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorResponses class' category: #TusLibros!
MerchantProcessorResponses class
	instanceVariableNames: ''!

!MerchantProcessorResponses class methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 18:51:48'!
expiredCardMessage

	^'1|EXPIRED_CARD'.! !

!MerchantProcessorResponses class methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 18:51:35'!
invalidCardMessage

	^'1|INVALID_CARD'.! !

!MerchantProcessorResponses class methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 19:06:28'!
stolenCardMessage

	^'1|STOLEN_CARD'.! !


!classDefinition: #SimulatedMerchantProcessor category: #TusLibros!
Object subclass: #SimulatedMerchantProcessor
	instanceVariableNames: 'invalidCards stolenCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 19:46:08'!
checkout: aCreditCard amount: anAmount

	(invalidCards includes: aCreditCard) ifTrue: [^MerchantProcessorResponses invalidCardMessage ].
	(stolenCards includes: aCreditCard) ifTrue: [^MerchantProcessorResponses stolenCardMessage ].
	aCreditCard expiration < GregorianMonthOfYear current ifTrue: [^MerchantProcessorResponses expiredCardMessage ].
	^SimulatedMerchantProcessor dummyTransactionMessage.
	! !

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 18:47:05'!
flagAsInvalid: aCreditCard.

	invalidCards add: aCreditCard.	! !

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 19:04:14'!
flagAsStolen: aCreditCard

	stolenCards add: aCreditCard.! !

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 19:04:32'!
initialize

	invalidCards := OrderedCollection new.
	stolenCards := OrderedCollection new.! !

!SimulatedMerchantProcessor methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 19:18:37'!
validateCard: aCreditCard

	(invalidCards includes: aCreditCard) ifTrue: [^MerchantProcessorResponses invalidCardMessage ].
	(stolenCards includes: aCreditCard) ifTrue: [^MerchantProcessorResponses stolenCardMessage ].
	aCreditCard expiration < GregorianMonthOfYear current ifTrue: [^MerchantProcessorResponses expiredCardMessage ].
	^SimulatedMerchantProcessor dummyTransactionMessage.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SimulatedMerchantProcessor class' category: #TusLibros!
SimulatedMerchantProcessor class
	instanceVariableNames: ''!

!SimulatedMerchantProcessor class methodsFor: 'as yet unclassified' stamp: 'lf 6/9/2019 19:18:51'!
dummyTransactionMessage

	^'0|3214'.! !
