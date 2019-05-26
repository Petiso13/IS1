!classDefinition: #PortfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 17:44:11'!
test01PortfolioHasBalance0WhenCreated

	| portfolio |
	
	portfolio := Portfolio new.
	self assert: 0 equals: portfolio balance. ! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 17:48:48'!
test02PortfolioCanReceiveAccounts

	| portfolio account |
	
	portfolio := Portfolio new.
	account := ReceptiveAccount new.
	portfolio add: account.
	self assert: (portfolio contains: account).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 19:41:25'!
test03AnAccountCanNotBeAddedToASecondPortfolio

	| portfolio account anotherPortfolio|
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	
	portfolio add: account.
	
	self
		should: [ anotherPortfolio add: account ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = ReceptiveAccount alreadyInAPortfolioErrorDescription ].	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 18:25:06'!
test04APortfolioCanBeAddedToAnotherPortfolio

	| portfolio account anotherPortfolio|
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio add: account.
	anotherPortfolio add: portfolio.
	self assert: (anotherPortfolio contains: portfolio).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 18:25:34'!
test05APortfolioRecognizesInnerAccounts

	| portfolio account anotherPortfolio|
	
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	account := ReceptiveAccount new.
	
	portfolio add: account.
	anotherPortfolio add: portfolio.
	self assert: (anotherPortfolio contains: portfolio).
	self assert: (anotherPortfolio contains: account).! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 18:54:55'!
test06APortfolioCanNotAddItself

	| portfolio |
	
	portfolio := Portfolio new.
	
	self should: [portfolio add: portfolio.]
	raise: Error
	withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio portfolioCannotContainItselfErrorDescription ].	
	
	! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 19:00:10'!
test07PortfolioAcccuratelyCalculatesBalance

	| portfolio account anotherPortfolio|
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
			
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	portfolio add: account.
	anotherPortfolio add: portfolio.
	self assert: 50 equals: portfolio balance .
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 19:11:34'!
test08PortfolioRecognizesWhichTranslationsItContains

	| portfolio account anotherPortfolio deposit withdraw otherWithdraw|
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	otherWithdraw := Withdraw for: 50.
			
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
	
	portfolio add: account.
	anotherPortfolio add: portfolio.
	self deny: (anotherPortfolio hasRegistered: otherWithdraw).
	self assert: (anotherPortfolio hasRegistered: deposit).
	self assert: (portfolio hasRegistered: withdraw ).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 19:21:13'!
test09PortfolioKnowsItsTransactions

	| portfolio account anotherPortfolio deposit|
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
				
	portfolio := Portfolio new.
	anotherPortfolio := Portfolio new.
		
	portfolio add: account.
	anotherPortfolio add: portfolio.

	self assert: 1 equals: anotherPortfolio transactions size .
	self assert: (anotherPortfolio transactions includes: deposit).
! !

!PortfolioTest methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 19:49:08'!
test10APortfolioCanNotBeAddedToTwoDifferentPortfolios

	| portfolioA portfolioB portfolioC |
	
	portfolioA := Portfolio new.
	portfolioB := Portfolio new.
	portfolioC := Portfolio new.
	
	
	portfolioA add: portfolioC.
	
	self
		should: [ portfolioB add: portfolioC ]
		raise: Error 
		withExceptionDo: [ :anError |
			self assert: anError messageText = Portfolio alreadyInAPortfolioErrorDescription ].	
	! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'lf 5/26/2019 17:40:23'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'lf 5/23/2019 20:22:36'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 17:08:53'!
modifyBalance: aBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'lf 5/23/2019 20:29:49'!
register: aValue on: account

	| transaction |
	
	transaction := self for: aValue.
	account register: transaction.
		
	^ transaction! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !

!Deposit methodsFor: 'initialization' stamp: 'lf 5/26/2019 17:18:43'!
modifyBalance: aBalance

	^aBalance + value.! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'lf 5/26/2019 17:06:55'!
initializeFor: aValue

	value := aValue ! !

!Withdraw methodsFor: 'initialization' stamp: 'lf 5/26/2019 17:10:39'!
modifyBalance: aBalance

	^aBalance - value.! !


!Withdraw methodsFor: 'value' stamp: 'lf 5/26/2019 17:05:39'!
value

	^ value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Portfolio category: #'Portfolio-Ejercicio'!
Object subclass: #Portfolio
	instanceVariableNames: 'accountsAndPortfolios linkedPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Portfolio methodsFor: 'initialization' stamp: 'lf 5/26/2019 17:50:10'!
initialize

	accountsAndPortfolios := OrderedCollection new.

	! !


!Portfolio methodsFor: 'testing' stamp: 'lf 5/26/2019 18:31:57'!
contains: accountOrPortfolio

	^(accountsAndPortfolios includes: accountOrPortfolio) or: (self searchPortfoliosFor: accountOrPortfolio).

	! !

!Portfolio methodsFor: 'testing' stamp: 'lf 5/26/2019 18:29:00'!
searchPortfoliosFor: accountOrPortfolio

	| portfolios |
	portfolios := accountsAndPortfolios select: [:a | a isKindOf: Portfolio ].
	^portfolios anySatisfy: [:a | a contains: accountOrPortfolio ].

	! !


!Portfolio methodsFor: 'portfolio' stamp: 'lf 5/26/2019 19:46:05'!
add: accountOrPortfolio

	accountOrPortfolio linkToAPortfolio: self.
	accountsAndPortfolios add: accountOrPortfolio.

	! !

!Portfolio methodsFor: 'portfolio' stamp: 'lf 5/26/2019 19:50:29'!
linkToAPortfolio: aPortfolio

	linkedPortfolio ifNotNil: [self error: Portfolio alreadyInAPortfolioErrorDescription ].
	self = aPortfolio ifTrue: [self error: Portfolio portfolioCannotContainItselfErrorDescription ].
	linkedPortfolio := aPortfolio.! !

!Portfolio methodsFor: 'portfolio' stamp: 'lf 5/26/2019 19:42:16'!
linkedPortfolio

	^linkedPortfolio ! !


!Portfolio methodsFor: 'transactions' stamp: 'lf 5/26/2019 18:59:06'!
balance

	| balance |
	balance := 0.
	accountsAndPortfolios do: [ :accountOrPortfolio | balance := balance + accountOrPortfolio balance].
	^balance! !

!Portfolio methodsFor: 'transactions' stamp: 'lf 5/26/2019 19:15:27'!
hasRegistered: aTransaction

	^accountsAndPortfolios anySatisfy: [:accountOrPortfolio | accountOrPortfolio hasRegistered: aTransaction.]
! !

!Portfolio methodsFor: 'transactions' stamp: 'lf 5/26/2019 19:54:19'!
transactions

	| transactions |
	transactions := OrderedCollection new.
	accountsAndPortfolios do: [ :accountOrPortfolio | transactions addAll: accountOrPortfolio transactions ].
	^transactions.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Ejercicio'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 19:40:47'!
alreadyInAPortfolioErrorDescription

	^'This portfolio is already a part of a different portfolio.'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 18:53:59'!
portfolioCannotContainItselfErrorDescription

	^'A portfolio can not contain itself'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
Object subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions linkedPortfolio'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'lf 5/26/2019 17:21:04'!
balance

	| balance |
	balance := 0.
	transactions do: [ :aTransaction | balance := aTransaction modifyBalance: balance].
	^balance! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'portfolio' stamp: 'lf 5/26/2019 19:50:54'!
linkToAPortfolio: aPortfolio

	linkedPortfolio ifNotNil: [self error: ReceptiveAccount alreadyInAPortfolioErrorDescription ].
	linkedPortfolio := aPortfolio.! !

!ReceptiveAccount methodsFor: 'portfolio' stamp: 'lf 5/26/2019 19:34:54'!
linkedPortfolio 

	^linkedPortfolio.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ReceptiveAccount class' category: #'Portfolio-Ejercicio'!
ReceptiveAccount class
	instanceVariableNames: ''!

!ReceptiveAccount class methodsFor: 'as yet unclassified' stamp: 'lf 5/26/2019 19:40:27'!
alreadyInAPortfolioErrorDescription

	^'This account already belongs to a portfolio'! !
