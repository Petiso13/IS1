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
	instanceVariableNames: 'testStack testFinder'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'lf 4/21/2019 00:35:01'!
setUp

	testStack := OOStack new.
	testFinder := SentenceFinderByPrefix with: testStack.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'lf 4/21/2019 00:36:26'!
test01SearchForValidPrefixInEmptyStackReturnsNotFoundMessage

	| validPrefix|
	
	validPrefix := 'asdf'.
		
	self assert: (testFinder find: validPrefix) equals: (SentenceFinderByPrefix noHitsMessageWith: validPrefix).	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 19:16:08'!
test02CannotSearchForEmptyPrefix

	| emptyPrefix|
	
	emptyPrefix := ''.
	
	self 
		should: [testFinder find: emptyPrefix]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix cannotSearchForEmptyPrefixErrorDescription].
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 19:23:00'!
test03CannotSearchForPrefixWithASpace

	| prefixWithSpaces |
	
	prefixWithSpaces := 'Winter is here'.
	
	self 
		should: [testFinder find: prefixWithSpaces ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: SentenceFinderByPrefix cannotSearchForPrefixWithSpacesErrorDescription ].
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'lf 4/21/2019 00:36:33'!
test04SearchWithNoHitsReturnsNotFoundMessage

	| aSentence aPrefix|

	self setUp.
	aSentence := 'I like cheeeeese'.
	aPrefix := 'like'.
	
	testStack push: aSentence. 	
	self assert: (testFinder find: aPrefix) equals: (SentenceFinderByPrefix noHitsMessageWith: aPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 02:51:37'!
test05SearchWithNoHitsDoesntModifyStack

	| aSentence aPrefix|

	self setUp.
	aSentence := 'I like cheeeeese'.
	aPrefix := 'like'.
	
	testStack push: aSentence.
	testFinder find: aPrefix.
	. 
	self assert: testStack top equals: aSentence.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 02:56:25'!
test06SearchWithOneHitReturnsSentence

	| aSentence aPrefix searchResult|

	self setUp.
	aSentence := 'Dont you cry'.
	aPrefix := 'Do'.
	
	testStack push: aSentence.
	searchResult := testFinder find: aPrefix.
	. 
	self assert: searchResult last equals: aSentence.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 02:58:00'!
test07SearchWithOneHitDoesntModifyStack

	| aSentence aPrefix|

	self setUp.
	aSentence := 'Dont you cry'.
	aPrefix := 'Dont'.
	
	testStack push: aSentence.
	testFinder find: aPrefix.
	. 
	self assert: testStack top equals: aSentence.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 03:19:13'!
test08SearchWithMultipleHitsReturnsAllSentences

	| aSentence anotherSentence aThirdSentence aPrefix searchResult|

	self setUp.
	aSentence := 'Dont you cry'.
	anotherSentence := 'Doesnt matter'.
	aThirdSentence := 'Wayward Son'.
	aPrefix := 'Do'.
	
	testStack push: aSentence.
	testStack push: anotherSentence.
	testStack push: aThirdSentence.
	searchResult := testFinder find: aPrefix.
	. 
	self assert: searchResult last equals: aSentence.
	searchResult removeLast.
	self assert: searchResult last equals: anotherSentence.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 03:27:40'!
test09SearchWithMultipleHitsDoesntModifyStack

	| aSentence anotherSentence aThirdSentence aPrefix|

	self setUp.
	aSentence := 'Dont you cry'.
	anotherSentence := 'Doesnt matter'.
	aThirdSentence := 'Wayward Son'.
	aPrefix := 'Do'.
	
	testStack push: aSentence.
	testStack push: anotherSentence.
	testStack push: aThirdSentence.
	
	testFinder find: aPrefix.
	
	self assert: testStack top equals: aThirdSentence.
	testStack pop.
	self assert: testStack top equals: anotherSentence.
	testStack pop.
	self assert: testStack top equals: aSentence.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 03:30:11'!
test10SearchIsCaseSensitive

	| aSentence anotherSentence aThirdSentence aPrefix searchResult|

	self setUp.
	aSentence := 'Dont you cry'.
	anotherSentence := 'doesnt matter'.
	aThirdSentence := 'Wayward Son'.
	aPrefix := 'Do'.
	
	testStack push: aSentence.
	testStack push: anotherSentence.
	testStack push: aThirdSentence.
	searchResult := testFinder find: aPrefix.
	. 
	self assert: searchResult last equals: aSentence.
	! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 15:53:22'!
test11SentencesBeginningWithSpacesAreAlsoHits

	| aSentence anotherSentence aThirdSentence aPrefix searchResult |

	self setUp.
	aSentence := 'Dont you cry'.
	anotherSentence := '   Doesnt matter'.
	aThirdSentence := 'Wayward Son'.
	aPrefix := 'Do'.
	
	testStack push: aSentence.
	testStack push: anotherSentence.
	testStack push: aThirdSentence.
	
	searchResult := testFinder find: aPrefix.
	
	self assert: searchResult size equals: 2. 
	self assert: searchResult last equals: aSentence.
	self assert: searchResult first equals: anotherSentence.! !

!SentenceFinderByPrefixTest methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 03:44:52'!
test12PrefixCanBeLongerThanSentences

	| aSentence anotherSentence aThirdSentence aPrefix searchResult|

	self setUp.
	aSentence := 'Dont'.
	anotherSentence := 'doe'.
	aThirdSentence := 'Dontcha know it?'.
	aPrefix := 'Dontcha'.
	
	testStack push: aSentence.
	testStack push: anotherSentence.
	testStack push: aThirdSentence.
	searchResult := testFinder find: aPrefix.
	. 
	self assert: searchResult last equals: aThirdSentence.

! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'colection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:36:08'!
initialize

	colection := OrderedCollection new.
	colection addLast: (StackElementValueless with: colection).! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:36:24'!
isEmpty

	^colection size =1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:47:03'!
pop
	|elementToRemove|
	elementToRemove := self top.
	colection last removeFromStack.
	^elementToRemove.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:47:42'!
push: anObject

	|elementToAdd|
	elementToAdd := StackElementWithValue with: colection.
	elementToAdd assignContent: anObject.
	colection addLast: elementToAdd.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:37:38'!
size

	 ^colection size - 1.! !

!OOStack methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:37:49'!
top

	^colection last elementValue.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackToSearchIn'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 20:53:52'!
checkValidityOfPrefix: prefixToSearchFor
	| spaceChar |

	spaceChar := $ .

	prefixToSearchFor isEmpty ifTrue: [self error: SentenceFinderByPrefix cannotSearchForEmptyPrefixErrorDescription].
	(prefixToSearchFor allSatisfy: [:char | char ~= spaceChar]) ifFalse: [self error: SentenceFinderByPrefix cannotSearchForPrefixWithSpacesErrorDescription].
	
	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 15:51:21'!
find: prefixToSearchFor

	| sentencesToReturn auxStack stringToCompare|

	self checkValidityOfPrefix: prefixToSearchFor .
	stackToSearchIn isEmpty ifTrue: [^SentenceFinderByPrefix noHitsMessageWith: prefixToSearchFor ].
	
	sentencesToReturn := OrderedCollection new.
	auxStack := OOStack new.
	
	[stackToSearchIn isEmpty] whileFalse: [
		(stackToSearchIn top size >= prefixToSearchFor size)ifTrue:[
			stringToCompare := stackToSearchIn top.
			stringToCompare := self removeSpacesAtTheBeginnigOf: stringToCompare.
			stringToCompare := stringToCompare copyFrom: 1 to: prefixToSearchFor size.
			stringToCompare = prefixToSearchFor ifTrue: [sentencesToReturn addLast: (stackToSearchIn top copyFrom: 1 to: stackToSearchIn top size)].			
		].
		auxStack push: stackToSearchIn pop.
	].
	
	[auxStack isEmpty] whileFalse: [stackToSearchIn push: auxStack pop].
	
	sentencesToReturn isEmpty ifTrue: [^SentenceFinderByPrefix noHitsMessageWith: prefixToSearchFor].
	^sentencesToReturn 

	
	! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 20:55:09'!
initializeWith: aStack

	stackToSearchIn := aStack. ! !

!SentenceFinderByPrefix methodsFor: 'as yet unclassified' stamp: 'ic 4/21/2019 15:20:35'!
removeSpacesAtTheBeginnigOf: aSentence

	| firstCharPosition spaceChar return|
	
	firstCharPosition := 1.
	spaceChar := $ .
	
	[(aSentence at: firstCharPosition) = spaceChar ] whileTrue:[
		firstCharPosition := firstCharPosition + 1.].
	
	return := aSentence copyFrom: firstCharPosition to: aSentence size.
	
	 ^"firstCharPosition "return.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 18:25:53'!
cannotSearchForEmptyPrefixErrorDescription

	^'Please enter a prefix'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 18:26:32'!
cannotSearchForPrefixWithSpacesErrorDescription

	^ 'Prefix must not contain spaces'.! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'lf 4/21/2019 00:35:42'!
noHitsMessageWith: aPrefix

	^ 'No sentences beginning with ', aPrefix, ' found.' .! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 23:20:16'!
noHitsMessagewith: aPrefix

	^ 'No sentences beginning with ', aPrefix, ' found.' .! !

!SentenceFinderByPrefix class methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 02:16:54'!
with: aStack

	^self new initializeWith: aStack. 

 ! !


!classDefinition: #StackElement category: #'Stack-Exercise'!
Object subclass: #StackElement
	instanceVariableNames: 'stackContainer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElement methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:25:52'!
elementValue

	self subclassResponsibility ! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:25:13'!
initializeWith: aStack

	stackContainer := aStack.! !

!StackElement methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:25:32'!
removeFromStack

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'StackElement class' category: #'Stack-Exercise'!
StackElement class
	instanceVariableNames: ''!

!StackElement class methodsFor: 'as yet unclassified' stamp: 'lf 4/19/2019 01:33:52'!
with: aStack 
	
	^self new initializeWith: aStack.! !


!classDefinition: #StackElementValueless category: #'Stack-Exercise'!
StackElement subclass: #StackElementValueless
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElementValueless methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:18:55'!
elementValue

	self error: OOStack stackEmptyErrorDescription.! !

!StackElementValueless methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:20:12'!
removeFromStack

	self error: OOStack stackEmptyErrorDescription.! !


!classDefinition: #StackElementWithValue category: #'Stack-Exercise'!
StackElement subclass: #StackElementWithValue
	instanceVariableNames: 'content'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!StackElementWithValue methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:30:30'!
assignContent: contentToAssign

	content := contentToAssign.! !

!StackElementWithValue methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:32:47'!
elementValue

	^content.! !

!StackElementWithValue methodsFor: 'as yet unclassified' stamp: 'ic 4/20/2019 21:49:56'!
removeFromStack

	stackContainer removeLast.
	! !
