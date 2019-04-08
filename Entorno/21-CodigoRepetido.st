!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/4/2019 19:53:05'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertClosure:[customerBook addCustomerNamed: 'John Lennon'.]runsFasterThan:50.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/4/2019 19:53:54'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	  
	self assertClosure:[customerBook removeCustomerNamed: paulMcCartney.]runsFasterThan:100.
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/7/2019 21:15:29'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self for:[customerBook addCustomerNamed: ''.] on: Error
	do: [ :anError | 
			self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
			self assert: customerBook isEmpty ]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/4/2019 21:48:45'!
test04CanNotRemoveAnInvalidCustomer

	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self for:[ customerBook removeCustomerNamed: 'Paul McCartney'.] on: NotFound
	assert: customerBook numberOfCustomers = 1 and: (customerBook includesCustomerNamed: johnLennon).! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/4/2019 21:16:32'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.

	self assertNumberOfTotalCustomersIs: 1 numberOfActiveCustomersIs: 0 numberOfSuspendedCustomersIs: 1 in: customerBook.
	self assert: (customerBook includesCustomerNamed: paulMcCartney).
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/4/2019 21:17:30'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self assertNumberOfTotalCustomersIs: 0 numberOfActiveCustomersIs: 0 numberOfSuspendedCustomersIs: 0 in: customerBook.
	self deny: (customerBook includesCustomerNamed: paulMcCartney).


	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/4/2019 21:51:55'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self for:[customerBook suspendCustomerNamed: 'Paul McCartney'.] on: CantSuspend 
	assert: customerBook numberOfCustomers = 1 and: (customerBook includesCustomerNamed: johnLennon).
	! !

!CustomerBookTest methodsFor: 'testing' stamp: 'lf 4/7/2019 21:12:49'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self for:[customerBook suspendCustomerNamed: johnLennon.]on:CantSuspend
	assert: customerBook numberOfCustomers = 1 and: (customerBook includesCustomerNamed: johnLennon).
! !


!CustomerBookTest methodsFor: 'auxiliary' stamp: 'lf 4/4/2019 19:46:00'!
assertClosure: closure runsFasterThan: numberOfMilliseconds
"Asserts that 'closure' runs in less than 'numberOfMilliseconds' milliseconds. "
	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	closure value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.

	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (numberOfMilliseconds * millisecond)
! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'lf 4/7/2019 21:26:50'!
assertNumberOfTotalCustomersIs: totalCustomers numberOfActiveCustomersIs: activeCustomers numberOfSuspendedCustomersIs: suspendedCustomers in: customerBook
    
    self assert: totalCustomers equals: customerBook numberOfCustomers.
    self assert: activeCustomers equals: customerBook numberOfActiveCustomers.
    self assert: suspendedCustomers equals: customerBook numberOfSuspendedCustomers.
! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'lf 4/7/2019 21:16:30'!
for: aClosure on: aMessage assert: anAssertion and: anotherAssertion

	[ aClosure value.
	self fail ]
		on: aMessage
		do: [
			self assert: anAssertion.
			self assert: anotherAssertion ]
		
! !

!CustomerBookTest methodsFor: 'auxiliary' stamp: 'lf 4/7/2019 21:16:55'!
for: aClosure on: aMessage do: aBlock

	[ aClosure value.
	self fail ]
		on: aMessage
		do: [:anError | aBlock value: anError.]! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
