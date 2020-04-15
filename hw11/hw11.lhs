Jonathan Wu
> module HW11
> where

Define factorial. Let Haskell infer the type of factorial

> factorial n = if n == 0 then 1 else n * factorial (n - 1)

infered type: this is a union of a num and equality (==), t takes 1 argument, and returns 1 value. factorial :: (Num t, Eq t) => t -> t

> fact1 :: Int -> Int
> fact1 n = if n == 0 then 1 else n * fact1 (n - 1)

> fact2 :: Integer -> Integer
> fact2 n = if n == 0 then 1 else n * fact2 (n - 1)


Hw11> factorial 12		479001600
Hw11> fact1 12			479001600
Hw11> fact2 12			479001600
Hw11> factorial 13		6227020800
Hw11> fact1 13			6227020800
Hw11> fact2 13			6227020800
Hw11> factorial 500		1220136825991110068701238785423046926253574342803192842192413588385845373153881997605496447502203281863013
6164771482035841633787220781772004807852051593292854779075719393306037729608590862704291745478824249127263
4430567017327076946106280231045264421887878946575477714986349436778103764427403382736539747138647787849543
8489595537537990423241061271326984327745715546309977202781014561081188373709531016356324432987029563896628
9116589747695720879269288712817800702651745077684107196243903943225364226052349458501299185715012487069615
6814162535905669342381300885624924689156412677565448188650659384795177536089400574523894033579847636394490
5313062323749066445048824665075946735862074637925184200459369692981022263971952597190945217823331756934581
5085523328207628200234026269078983424517120062077146409794561161276291459512372299133401695523638509428855
9201872743379517301458635757082835578015873543276888868012039988238470215146760544540766353598417443048012
8938313896881639487469658817504506926365338175055478128640000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000

Hw11> fact1 500			0
Hw11> fact2 500
1220136825991110068701238785423046926253574342803192842192413588385845373153881997605496447502203281863013
6164771482035841633787220781772004807852051593292854779075719393306037729608590862704291745478824249127263
4430567017327076946106280231045264421887878946575477714986349436778103764427403382736539747138647787849543
8489595537537990423241061271326984327745715546309977202781014561081188373709531016356324432987029563896628
9116589747695720879269288712817800702651745077684107196243903943225364226052349458501299185715012487069615
6814162535905669342381300885624924689156412677565448188650659384795177536089400574523894033579847636394490
5313062323749066445048824665075946735862074637925184200459369692981022263971952597190945217823331756934581
5085523328207628200234026269078983424517120062077146409794561161276291459512372299133401695523638509428855
9201872743379517301458635757082835578015873543276888868012039988238470215146760544540766353598417443048012
8938313896881639487469658817504506926365338175055478128640000000000000000000000000000000000000000000000000
000000000000000000000000000000000000000000000000000000000000000000000000000

factorial 500 and fact2 500 both give the correct answer since type Integer is as large as we need it to be. factorial is of type num, which is a typeclass. The typeclass num allows us to choose an int verses an integer. Since there is implicit type casting factorial chooses type integer. Type integer changes to accomidate size while type int is a set size, and overflow is assumed to have occured. 

:t fact1			fact1 :: Int -> Int
:t fact1 5 			fact1 5 :: Int
:t (*)				(*) :: Num a => a -> a -> a
:t (==) 			(==) :: Eq a => a -> a -> Bool
:t 5				5 :: Num t => t
:t 5.1				5.1 :: Fractional t => t
:t 5::Int			5::Int :: Int
:t factorial			factorial :: (Num t, Eq t) => t -> t
:t factorial 5			factorial 5 :: (Num t, Eq t) => t
:t (-)				(-) :: Num a => a -> a -> a
:t (2-) 			(2-) :: Num a => a -> a
:t (-) 2			(-) 2 :: Num a => a -> a
:t error			error :: [Char] -> a
:t (2 - ) --Currying.  		(2 -) --Currying :: Num a => a -> a

"Num a" means Num is a set of types and a belongs to the set. Examples of types that belong to Num are Int, Integer, Float as well as user defined types. Haskell calls these sets  --CLASSES--  At the prompt type the following expressions:
Hw11> factorial (-2)

*** Exception: stack overflow

This happens since -2 cannot be used for the factorial function, it doesnt work with negative numbers. There is also no check to see if -2 is out of bounds or valid, so we get the stack overflow error message.

At the prompt type the following expressions:

Hw11> factorial -2

What happens?
  • Non type-variable argument in the constraint: Num (t -> t)
      (Use FlexibleContexts to permit this)
    • When checking the inferred type
        it :: forall t. (Num (t -> t), Num t, Eq t) => t -> t

Haskell doesnt know that the - sign means a negative sign. Haskell assumes that we are inferring types. TO fix this you can use () to make sure the right type is passed.


> factP :: Integer -> Integer
> factP 0 = 1
> factP n = n * factP(n -1)

> factG x
>     | x < 0     = error "neg x"
>     | x == 0    = 1
>     | otherwise = x*factG(x-1)

There is only one definition of factG which uses recursion. When we type factG(-2), we get an error **Exception: negx. This is the expected error, when there is a value less than 0 we raise an error "neg x".


> factI :: Integer -> Integer
> factI n
>     | n < 0     = error "neg n"
>     | n == 0    = 1
>     | otherwise = n * factI (n - 1)


> factE :: Integer -> Integer
> factE n
>     | n < 0     = error "neg n"
>     | n == 0    = 1
>     | otherwise = n * factE n - 1


Hw11> factorial 5.1 	*** Exception: stack overflow

Hw11> factG 5.1		*** Exception: neg x
CallStack (from HasCallStack):
  error, called at Hw11.lhs:88:21 in main:HW11

Hw11> factI 5.1
<interactive>:38:8: error:
    • No instance for (Fractional Integer)
        arising from the literal ‘5.1’
    • In the first argument of ‘factI’, namely ‘5.1’
      In the expression: factI 5.1
      In an equation for ‘it’: it = factI 5.1


For the first case, factorial 5.1 is a num, so there is no issue. Factorial gives us a stack overflow since after 5.1 goes to 4.1 to 3.1 to 2.1 to 1.1 to 0.1, there is no check to see if .1 == 0, and goes to a negative value, hence the stack overflow error.

For factI it is of type num which is correct. After we get a negative value (-.9), we get the error message "neg x", which is what we want, and the function returns.

For factI, the contraint is of type Integer, so the function won't even start since we are passing in a float value.



factI 5 	120
factE 5		*** Exception: stack overflow

What happens? Try to guess why factE behaves this way?  

factI sends back 120 since 5 counts down till 0, and does the recursion properly. This function works as expected.

FactE gives us a stack overflow, since it only sends argument n back, and ignores the -1. This would give an error since you never actually decrement -1 and thereby get a stack overflow cause you get into an infinte loop

Part2
1. Tuple Data Type

> prodT (a,b,c) = a * b * c

prodT(2,3,4) = 24
prodT(2,-3,4) = -24
Inferred type: prodT :: Num a => (a, a, a) -> a	[takes a tuple of type num  and returns a type num]

2. Curried functions

> prodC a b c = a * b * c

Inferred type: prodC :: Num a => a -> a -> a -> a [takes 3 arguments of type num, returns a type num]


3. prodCx

> prodCx :: Num a => a -> (a -> (a->a))
> prodCx a b c = a * b * c

Inferred type: prodCx :: Num a => a -> a -> a -> a [same inferred type as part B]

4. add the following definition

> prodC1  = prodC 1
> prodC2  = prodC1 2
> prodC3  = prodC2 3
> prodC12 = prodC 1 2 4

All of these definitions are legal, since they are not tuple definitions, curring is allowed in functions without tuples

5. prodC1, prodC2, prodC3 and prodC12 all include use partially evalutated functions in their definitions.  Can you write similar definitions using prodT? For example are any of the following definitions legal?

 prodT1 = prodT 1
 prodT2 = prodT(1)
 prodT4 = prodT(1,2)
 prodT3 = prodT(1,x,y)

6. F G H, in terms of functions goes ((F G) H) ->evaluates left to right
