!classDefinition: #PortfolioTest category: #'31-Portfolio-Treeprinter'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !


!classDefinition: #ReceptiveAccountTest category: #'31-Portfolio-Treeprinter'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
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

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'lf 6/2/2019 21:44:21'!
test08TransferenceRegistersProperlyOnBothAccounts 

	| accountA accountB transference |
	
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.

	transference := Transference register: 100 from: accountA to: accountB.
		
	self assert: (accountA hasRegistered: transference ).
	self assert: (accountB hasRegistered: transference ).! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'lf 6/2/2019 19:52:02'!
test09TransferenceAffectsBothAccountsBalanceProperly 

	| accountA accountB |
	
	
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	Deposit register: 100 on: accountB.
	Transference register: 50 from: accountA to: accountB.
		
	self assert: 50 equals: accountA balance.
	self assert: 150 equals: accountB balance.! !


!classDefinition: #ReportTest category: #'31-Portfolio-Treeprinter'!
TestCase subclass: #ReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!ReportTest methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:05:14'!
test01AccountSummaryReportPrintsCorrectlyOnASingleAccount

	| expectedReport accountA accountB |
		
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	Transference register: 50 from: accountA to: accountB.
	
	expectedReport := 
'Deposito por 100.
Extracción por 50.
Salida por transferencia de 50.
Balance = 0'.
		
	self assert: (AccountSummary new for: accountA) equals: expectedReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:05:36'!
test02AccountSummaryReportPrintsCorrectlyOnAPortfolioWithMultipleAccounts

	| expectedReport accountA accountB portfolio |
		
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	portfolio := Portfolio new.
	
	portfolio add: accountA.
	portfolio add: accountB.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	Transference register: 50 from: accountA to: accountB.
	Deposit register: 200 on: accountB.
	
	expectedReport := 
'Deposito por 100.
Extracción por 50.
Salida por transferencia de 50.
Entrada por transferencia de 50.
Deposito por 200.
Balance = 250'.
		
	self assert: (AccountSummary new for: portfolio) equals: expectedReport.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:08:05'!
test03TransferNetReportWorksCorrectlyOnASingleAccount

	| expectedReportA expectedReportB accountA accountB |
		
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	Transference register: 50 from: accountA to: accountB.
	
	expectedReportA := -50.
	expectedReportB := 50.
	
	self assert: (TransferNet new for: accountA) equals: expectedReportA.
	self assert: (TransferNet new for: accountB) equals: expectedReportB.! !

!ReportTest methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:09:52'!
test04TransferNetReportWorksCorrectlyOnAPortfolioWithMultipleAccounts

	| expectedReport accountA accountB accountC portfolio |
		
	accountA := ReceptiveAccount new.
	accountB := ReceptiveAccount new.
	accountC := ReceptiveAccount new.
		
	portfolio := Portfolio new.
	
	portfolio add: accountA.
	portfolio add: accountB.
	
	Deposit register: 100 on: accountA.
	Withdraw register: 50 on: accountA.
	Transference register: 50 from: accountA to: accountB.
	Transference register: 50 from: accountC to: accountA.
	Deposit register: 200 on: accountB.
	
	expectedReport := 50.
	self assert: (TransferNet new for: portfolio) equals: expectedReport.! !


!classDefinition: #Account category: #'31-Portfolio-Treeprinter'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'31-Portfolio-Treeprinter'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'31-Portfolio-Treeprinter'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'31-Portfolio-Treeprinter'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'lf 6/2/2019 21:12:00'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'lf 6/2/2019 21:34:45'!
hasRegistered: aTransaction

	^ aTransaction isRegisteredIn: transactions. 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!classDefinition: #AccountTransaction category: #'31-Portfolio-Treeprinter'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'lf 6/2/2019 21:11:49'!
affectBalance: aBalance

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'lf 6/2/2019 21:35:20'!
isRegisteredIn: transactions

	^transactions includes: self.! !

!AccountTransaction methodsFor: 'balance' stamp: 'lf 6/2/2019 21:12:40'!
print

	self subclassResponsibility ! !

!AccountTransaction methodsFor: 'balance' stamp: 'lf 6/2/2019 20:17:09'!
printFor: account

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'31-Portfolio-Treeprinter'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'31-Portfolio-Treeprinter'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'lf 6/2/2019 21:11:29'!
affectBalance: aBalance

	^aBalance + value ! !

!Deposit methodsFor: 'balance' stamp: 'lf 6/2/2019 21:12:50'!
print

	^'Deposito por ', value asString, '.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'31-Portfolio-Treeprinter'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferAction category: #'31-Portfolio-Treeprinter'!
AccountTransaction subclass: #TransferAction
	instanceVariableNames: 'account transference'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!TransferAction methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:26:50'!
initializeFor: anAccount with: aTransference

	account := anAccount.
	transference := aTransference.! !

!TransferAction methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:36:45'!
isRegisteredIn: transactions

	^transactions includes: transference.
	! !

!TransferAction methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:47:09'!
print

	self subclassResponsibility.! !

!TransferAction methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:18:20'!
value

	^transference value.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferAction class' category: #'31-Portfolio-Treeprinter'!
TransferAction class
	instanceVariableNames: ''!

!TransferAction class methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:32:24'!
for: anAccount with: aTransference

	^self new initializeFor: anAccount with: aTransference.! !


!classDefinition: #TransferFrom category: #'31-Portfolio-Treeprinter'!
TransferAction subclass: #TransferFrom
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!TransferFrom methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:45:13'!
affectBalance: aBalance

	^aBalance - transference value. ! !

!TransferFrom methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:49:51'!
print

	^'Salida por transferencia de ', transference value asString, '.'.! !


!classDefinition: #TransferTo category: #'31-Portfolio-Treeprinter'!
TransferAction subclass: #TransferTo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!TransferTo methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:45:35'!
affectBalance: aBalance

	^aBalance + transference value. ! !

!TransferTo methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:50:05'!
print

	^'Entrada por transferencia de ', transference value asString, '.'.! !


!classDefinition: #Transference category: #'31-Portfolio-Treeprinter'!
AccountTransaction subclass: #Transference
	instanceVariableNames: 'value from to'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!Transference methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:40:28'!
initializeFor: aValue from: accountA to: accountB

	value := aValue.
	from := TransferFrom for: accountA with: self.
	to := TransferTo for: accountB with: self.
	
	accountA register: from.
	accountB register: to.! !

!Transference methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:41:30'!
isRegisteredIn: transactions

	^(transactions includes: from) or: (transactions includes: to).! !

!Transference methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 19:40:22'!
value

	^ value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transference class' category: #'31-Portfolio-Treeprinter'!
Transference class
	instanceVariableNames: ''!

!Transference class methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 19:48:15'!
for: aValue from: accountA to: accountB

	^ self new initializeFor: aValue from: accountA to: accountB. ! !

!Transference class methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 21:47:53'!
register: aValue from: accountA to: accountB

	| transference |
	
	transference := Transference for: aValue from: accountA to: accountB.
	^transference.! !


!classDefinition: #Withdraw category: #'31-Portfolio-Treeprinter'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'lf 6/2/2019 21:11:40'!
affectBalance: aBalance

	^aBalance - value! !

!Withdraw methodsFor: 'balance' stamp: 'lf 6/2/2019 21:12:59'!
print

	^'Extracción por ', value asString, '.'.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'31-Portfolio-Treeprinter'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Report category: #'31-Portfolio-Treeprinter'!
Object subclass: #Report
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!Report methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:04:10'!
filter: transactions by: closure.

	^transactions select: closure.! !

!Report methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:04:23'!
for: anAccount

	self subclassResponsibility.! !


!classDefinition: #AccountSummary category: #'31-Portfolio-Treeprinter'!
Report subclass: #AccountSummary
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!AccountSummary methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:03:14'!
for: anAccount
	
	| stream transactions |
	
	stream _ String new writeStream.
	transactions := anAccount transactions.
	transactions do: [:a | stream nextPutAll: (a print); newLine.].
	stream nextPutAll: 'Balance = ', (anAccount balance asString).
	^stream contents.! !


!classDefinition: #TransferNet category: #'31-Portfolio-Treeprinter'!
Report subclass: #TransferNet
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: '31-Portfolio-Treeprinter'!

!TransferNet methodsFor: 'as yet unclassified' stamp: 'lf 6/2/2019 22:04:35'!
for: anAccount
	
	| transferences |
	transferences := self filter: anAccount transactions by: [:a | a isKindOf: TransferAction].
	^transferences 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance]! !
