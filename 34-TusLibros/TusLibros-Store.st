!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:50'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:51'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:04'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 19:00'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:59'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 19:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ]! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #StoreTest category: #TusLibros!
TestCase subclass: #StoreTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 20:19:09'!
debit: anAmount from: aCreditCard

	| debitBehavior |
	debitBehavior := [ :amount :creditCard | ].
	
	^debitBehavior value: anAmount value: aCreditCard. ! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/12/2019 21:44:04'!
setUp

	testObjectsFactory := StoreTestObjectsFactory new.
! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/12/2019 21:54:05'!
test01CartIsCreatedEmpty

	| store clientId password cartId |

	clientId := '1'.
	password := 'dummyHash'.

	store := Store with: testObjectsFactory defaultCatalog and: SimulatedPasswordValidator new.
	cartId := store createCartFor: clientId with: password.
	
	self assert: (store listCart: cartId) isEmpty.! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/21/2019 18:44:12'!
test02StoreCanAddItemsToExistingCart

	| store clientId password cartId |

	clientId := '1'.
	password := 'dummyHash'.

	store := Store with: testObjectsFactory defaultCatalog and: SimulatedPasswordValidator new.
	cartId := store createCartFor: clientId with: password.
	
	store addToCart: cartId item: testObjectsFactory itemSellByTheStore quantity: 1.
	self assert: ((store listCart: cartId) includes: testObjectsFactory itemSellByTheStore).! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 20:23:58'!
test03StoreCanCheckoutExistingCart

	| store clientId password cartId creditCard |

	clientId := '1'.
	password := 'dummyHash'.

	store := Store with: testObjectsFactory defaultCatalog and: SimulatedPasswordValidator new.
	cartId := store createCartFor: clientId with: password.
	
	store addToCart: cartId item: testObjectsFactory itemSellByTheStore quantity: 1.
	creditCard := testObjectsFactory notExpiredCreditCard.
	store checkout: cartId throught: self with: creditCard.
	
	self assert: store sales size = 1.! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 21:25:25'!
test04ListPurchasesReturnsThePurchasesMade

	| store clientId password cartId creditCard quantity passwordValidator |

	clientId := '1'.
	password := 'dummyHash'.
	quantity := 14.

	passwordValidator := SimulatedPasswordValidator new.
	store := Store with: testObjectsFactory defaultCatalog and: passwordValidator.
	cartId := store createCartFor: clientId with: password.
	
	store addToCart: cartId item: testObjectsFactory itemSellByTheStore quantity: quantity.
	creditCard := testObjectsFactory notExpiredCreditCard.
	store checkout: cartId throught: self with: creditCard.
	
	self assert: (store listPurchasesFor: clientId password: password) size equals: quantity.
	! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 21:24:29'!
test05StoreValidatesPasswords

	| store clientId password passwordValidator |

	clientId := '1'.
	password := 'dummyHash'.

	passwordValidator := SimulatedPasswordValidator new.
	passwordValidator shouldAcceptPassword: false.
	store := Store with: testObjectsFactory defaultCatalog and: passwordValidator.
	
	self 
		should: [ store createCartFor: clientId with: password. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = Store invalidUserOrPasswordErrorDescription.]! !

!StoreTest methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 21:59:39'!
test06CartExpiresAfter30Minutes

	| store clientId password passwordValidator cartId cart |

	clientId := '1'.
	password := 'dummyHash'.

	passwordValidator := SimulatedPasswordValidator new.
	passwordValidator shouldAcceptPassword: true.
	store := Store with: testObjectsFactory defaultCatalog and: passwordValidator.
	cartId := store createCartFor: clientId with: password.
	cart := store getCart: cartId.
	cart setCreationDate: DateAndTime yesterday.
	
	self 
		should: [ store listCart: cartId. ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText = Store expiredCartErrorDescription.]
		! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items creationDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'lf 6/23/2019 21:28:54'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.
	creationDate := DateAndTime now.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'lf 6/23/2019 21:41:16'!
creationDate
	
	^creationDate. ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !

!Cart methodsFor: 'testing' stamp: 'lf 6/23/2019 21:29:34'!
setCreationDate: aDate.
	creationDate := aDate. ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'as yet unclassified' stamp: 'lf 6/12/2019 21:47:48'!
items

	^items.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:07'!
createSale

	^ Sale of: total
! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:53'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:51'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 18:39'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:38'!
initializeExpiringOn: aMonth 
	
	expiration := aMonth ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:38'!
expiringOn: aMonth 
	
	^self new initializeExpiringOn: aMonth! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:47'!
initializeTotal: aTotal

	total := aTotal ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 18:47'!
of: aTotal

	"should assert total is not negative or 0!!"
	^self new initializeTotal: aTotal ! !


!classDefinition: #SimulatedPasswordValidator category: #TusLibros!
Object subclass: #SimulatedPasswordValidator
	instanceVariableNames: 'acceptPassword'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!SimulatedPasswordValidator methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 21:12:37'!
initialize

	acceptPassword := true.
! !

!SimulatedPasswordValidator methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 21:13:12'!
shouldAcceptPassword: aBoolean

	acceptPassword := aBoolean.! !

!SimulatedPasswordValidator methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 21:13:31'!
validate: aClientId with: aPassword

	^acceptPassword.! !


!classDefinition: #Store category: #TusLibros!
Object subclass: #Store
	instanceVariableNames: 'carts clients lastCartId clientCartIds catalog salesBook passwordValidator clientPurchases'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Store methodsFor: 'testing' stamp: 'lf 6/23/2019 21:38:30'!
getCart: aCartId

	| cart | 

	cart := carts at: aCartId ifAbsent: [self error: Store invalidCartErrorDescription]. 
	^cart.! !

!Store methodsFor: 'testing' stamp: 'lf 6/23/2019 20:11:28'!
sales

	^salesBook.! !


!Store methodsFor: 'validation' stamp: 'lf 6/23/2019 21:22:35'!
validate: aClientId with: aPassword
	
	(passwordValidator validate: aClientId with: aPassword) ifFalse:[self error: Store invalidUserOrPasswordErrorDescription].! !

!Store methodsFor: 'validation' stamp: 'lf 6/23/2019 21:56:58'!
validateCartExpiration: aCartId

	| cart | 

	cart := carts at: aCartId ifAbsent: [self error: Store invalidCartErrorDescription]. 
	((cart creationDate + 30minutes) < DateAndTime now) ifTrue:[self error: Store expiredCartErrorDescription].! !


!Store methodsFor: 'interface' stamp: 'lf 6/23/2019 21:58:10'!
addToCart: aCartId item: anItem quantity: aQuantity

	| cart | 
	self validateCartExpiration: aCartId.
	cart := carts at: aCartId ifAbsent: [self error: Store invalidCartErrorDescription].
	cart add: aQuantity of: anItem.! !

!Store methodsFor: 'interface' stamp: 'lf 6/23/2019 21:58:19'!
checkout: aCartId throught: aMerchantProcessor with: aCreditCard

	| cashier cart purchases clientId |
	self validateCartExpiration: aCartId.
	cart := carts at: aCartId ifAbsent: [self error: Store invalidCartErrorDescription].
	cashier:= Cashier 
		toCheckout: cart
		charging: aCreditCard
		throught: aMerchantProcessor
		on: DateAndTime now
		registeringOn: salesBook.
	
	cashier checkOut.
	
	purchases := cart items.
	
	clientId := self getClientIdFromCartId: aCartId.
	self addPurchases: purchases to: clientId.
	
"	
	(clientPurchases includesKey: aClientId) ifFalse:[clientCartIds at: aClientId put: OrderedCollection new].
	(clientCartIds at: aClientId) add: lastCartId.
"! !

!Store methodsFor: 'interface' stamp: 'lf 6/23/2019 21:20:32'!
createCartFor: aClientId with: aPassword

	| cart cartId |
	
	self validate: aClientId with: aPassword.
	cart := Cart acceptingItemsOf: catalog.
	cartId := self addCart: cart for: aClientId.
	^cartId.! !

!Store methodsFor: 'interface' stamp: 'lf 6/23/2019 21:58:27'!
listCart: aCartId

	| cart | 
	self validateCartExpiration: aCartId.
	cart := carts at: aCartId ifAbsent: [self error: Store invalidCartErrorDescription]. 
	^cart items.! !

!Store methodsFor: 'interface' stamp: 'lf 6/23/2019 21:22:13'!
listPurchasesFor: aClientId password: aPassword
	
	self validate: aClientId with: aPassword.
	^clientPurchases at: aClientId ifAbsent:[^OrderedCollection new].! !


!Store methodsFor: 'initialization' stamp: 'lf 6/23/2019 20:35:55'!
initializeAcceptingItemsOf: aCatalog with: aPasswordValidator

	passwordValidator := aPasswordValidator.
	lastCartId := 0.
	catalog := aCatalog.
	carts := Dictionary new.
	clients := Dictionary new.
	clientCartIds := Dictionary new.
	clientPurchases := Dictionary new.
	salesBook := OrderedCollection new.! !


!Store methodsFor: 'internal' stamp: 'lf 6/23/2019 21:33:45'!
addCart: cart for: aClientId

	lastCartId := lastCartId + 1.
	carts at: lastCartId put: cart.
	(clientCartIds includesKey: aClientId) ifFalse:[clientCartIds at: aClientId put: OrderedCollection new].
	(clientCartIds at: aClientId) add: lastCartId.
	^lastCartId.! !

!Store methodsFor: 'internal' stamp: 'lf 6/23/2019 21:07:37'!
addPurchases: purchases to: aClientId

	(clientPurchases includesKey: aClientId) ifFalse:[clientPurchases at: aClientId put: OrderedCollection new].
	(clientPurchases at: aClientId) addAll: purchases.! !

!Store methodsFor: 'internal' stamp: 'lf 6/23/2019 21:04:11'!
getClientIdFromCartId: aCartId

	^(clientCartIds select:[:cartIds | cartIds includes: aCartId]) keys first.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Store class' category: #TusLibros!
Store class
	instanceVariableNames: ''!

!Store class methodsFor: 'as yet unclassified' stamp: 'lf 6/23/2019 21:57:21'!
expiredCartErrorDescription

	^'This cart has already expired.'! !

!Store class methodsFor: 'as yet unclassified' stamp: 'lf 6/12/2019 21:49:22'!
invalidCartErrorDescription

	^'Invalid cart id.'! !

!Store class methodsFor: 'as yet unclassified' stamp: 'lf 6/12/2019 21:36:30'!
invalidUserOrPasswordErrorDescription

	^'Invalid user-password combination.'! !

!Store class methodsFor: 'as yet unclassified' stamp: 'lf 6/12/2019 21:53:02'!
with: aCatalog and: aPasswordValidator

	^self new initializeAcceptingItemsOf: aCatalog with: aPasswordValidator! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:37'!
expiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber - 1)! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'HernanWilkinson 6/17/2013 18:36'!
notExpiredCreditCard
	
	^CreditCard expiringOn: (Month month: today monthIndex year: today yearNumber + 1)! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !
