'From Cuis 5.0 of 7 November 2016 [latest update: #3685] on 7 April 2019 at 9:55:50 pm'!
!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

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
