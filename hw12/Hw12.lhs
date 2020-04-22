> module Hw12
>     where

Rename this file to "Hw12.lhs".
Add your code to this file in the positions indicated with "Problem N Answer:".
You will need to remove the spaces before ">" for the types to become part of
your code.

The names of the functions SHOULD NOT BE CHANGED. I will be grading these with
a script - if your code doesn't define the functions with the exact names
specified, they will be assumed skipped.

Once you've finished editing this file, submit it in a tar.gz directory
as usual.


Problem 1:

Write a function "sumALL" that takes a list of numbers and returns their sum.
This must be a recursive solution.  Your definition can use either "if" 
expression OR guard with pattern matching.

Example:
...> sumALL [2,7,4]
13

Problem 1 Answer:

> sumAll :: Num a => [a] -> a
> sumAll [] = error "list is empty"
> sumAll [x] = x
> sumAll (x:xs) = sumAll(xs) + x

Problem 2:

Write a function "binOpALL op lst" that takes an arbitrary binary operator and
a list of numbers and returns the result of applying the 'op' to the values in
list. To make things easier use the prefix notation for the operators,
e.g. (*) 3 2 evaluates to 6.
Example:
...> binOpALL (+) [2,7,4]
13

Problem 2 Answer:

> binOpALL :: Num a => (a -> a -> a) -> [a] -> a
> binOpALL op [] = 0
> binOpALL op [b] = b
> binOpALL op (x:xs) = (op) x (binOpALL op xs)

Problem 3:
Write a recursive function "insertAt v p lst" that inserts a value v at
position p in list lst. If p is greater than the length of lst, simply
insert it at the end. You should be able to insert to the beginning of the list,
the end of the list, and any index in between.
Example:
...> insertAt 12 1 [1,2,3]
[1,12,2,3]
...> insertAt 12 10 [1,2,3]
[1,2,3,12]
...> insertAt 12 0 [1,2,3]
[12,1,2,3]

Remember, Haskell is "pure", so you can not modify lst. Instead, you should
recurse and build a new list from lst with v inserted. 

Problem 3 Answer:

> insertAt :: (Eq a, Num a) => b -> a -> [b] -> [b]
> insertAt v p [] = [v] --empty list is just the value given
> insertAt v 0 (head:tail) = [v] ++ [head] ++ tail --base case when the index is 0
> insertAt v p (head:tail) = [head] ++ insertAt v (p - 1) tail --insertAt is being called recursivly



Problem 4. Thompson 10.3
Define a function composeList which composes a list of unary functions into a 
single function. You may assume the list of functions is not empty.
Define composeList using primitive recursion.
Example:
...> composeList [ (*) 2, (*) 2] 2
8
...> composeList [ (-) 3 , (*) 2, (+)5 ] 7 
-21
Notice how in the above example, the output of composeList [ (-) 3, (*) 2, (+) 5]
is the function f(x) = (3 - (2 * (5 + x))).


Problem 4 Answer:

> composeList [head] = head
> composeList (head:tail) =  head . composeList tail --pass the recursive case of compose list into the head
. operator = f.g where f(g())



Problem 5:
In homework 1 you were introduced to the Ackermann Numbers.
The definition we used in the assignment is:

	ack( m,n ) =	n + 1			    if m = 0
	ack( m,n ) =	ack(m - 1, 1)		    if n = 0 and m > 0 
	ack( m,n ) =	ack( m-1, ack( m, n-1 ) )   if n >0 and m > 0

Define the ack function in Haskell.
Example:
...> ack 0 3
4
...> ack 3 2
29

Problem 5 Answer:


> ack m n
>	| (m == 0) = (n + 1)
>	| (n == 0 && m > 0)	= (ack (m - 1) 1)
>	| (n > 0 && m > 0) = (ack (m - 1) (ack m (n - 1)))
>	| otherwise = 0


Problem 6: 
Implement Newton's method for calculating the square root of N.
Your definition should use primitive recursive style.
Your definition should include a user defined (input) "guess" value and a user 
defined "nearEnough" value.  
"nearEnough" is use to determine when the guess is close enough to the square root.
Stop when |(guess^2) - N| < nearEnough. You should not use sqrt in your function!
Locally defined helper functions may be a good idea with this problem to make your code more readable.

Example: 
...> newtonAppr 144 1 0.1             
12.000545730742438 
...> newtonAppr 144 1 0.0001
12.0000000124087
...> newtonAppr 144 1 0.000000000000001
12.0
...> newtonAppr 5e+30 1 1000000000000000000000000000000  
2.317148867384728e15
...> newtonAppr 5e+30 1 100000000000000000000000000    
2.2360684271923805e15

Problem 6 Answer:
Note: you may have a slightly different type depending on your
solution.

> newtonAppr :: (Fractional a, Ord a) => a -> a -> a -> a
> newtonAppr squareRoot guess t =
>	 let guessSquared = guess * guess
>	 in if (guessSquared <= squareRoot + t && guessSquared >= squareRoot - t)
>	    then guess
>	    else newtonAppr squareRoot (((squareRoot / guess) + guess) / 2) t


Problem 7: 

The Tree data type defined below is used to build a binary tree.


> data Tree a =  Nil  
>              | Node a (Tree a) (Tree a) deriving Eq

> instance Show a => Show (Tree a) where
>  show t = show' t 0
>    where
>      show' Nil ind = replicate ind ' ' ++ "Nil"
>      show' (Node v l r) ind = 
>        replicate ind ' ' ++ "(Node " ++ show v ++ "\n" ++ 
>        show' l (ind+1) ++ "\n" ++
>        show' r (ind+1) ++ "\n" ++
>        replicate ind ' ' ++ ")"

What are Tree, Nil and Node?

I have also provided a few default binary trees so you do not need to 
keep entering them into ghci. You may simply type tree1 at the prompt and you
will get a pretty print of tree1. Note these 3 examples are in fact binary
search trees.

> tree1 = Node 5 (Node 10 Nil (Node 12 Nil Nil) ) Nil
> tree2 = (Node 5 (Node 2 (Node 1 Nil Nil) (Node 3 Nil Nil)) (Node 7 Nil (Node 9 Nil Nil)))
> tree3 = (Node 5 (Node 2 (Node 1 Nil Nil) Nil) (Node 7 Nil (Node 9 Nil Nil)))


Define "flatten t" which converts a tree to a list.  You should do an 
inorder traversal of the tree. You may use "++" operator. 
What are your assumptions?  Can you predict the most general type of flatten?

    ...> flatten tree1
    [10,12,5]
	...> flatten Nil
    []

Answer 7:
   
> flatten :: Tree t -> [t]
> flatten (Node v left right) = flatten left ++ [v] ++ flatten right

Problem 8:
The harmonic series is the following infinite series:
                1   1   1   1             1
            1 + - + - + - + - + ... + ... - ...
                2   3   4   5             i
(http://en.wikipedia.org/wiki/Harmonic_series_(mathematics))

Write a function sumHarmonic such that sumHarmonic i is the sum of the first in
terms of this series. For example, sumHarmonic 4 ~> 1 + 1 + 1 + 1 ~> 2.08333...
                                                        2   3   4
Your answer should be in a simple recursive style.

Example:
...> sumHarmonic 4
2.08333...


Answer 8:

> sumHarmonic :: (Eq a, Fractional a) => a -> a
> sumHarmonic 1 = 1
> sumHarmonic a = 1/a + sumHarmonic (a-1)


Problem 9: (from http://en.wikipedia.org/wiki/Thue%E2%80%93Morse_sequence )
"In mathematics, the Thue-Morse sequence, or Prouhet-Thue-Morse sequence, is a 
binary sequence that begins:

  0 01 0110 01101001 0110100110010110 01101001100101101001011001101001 ...

(or if the sequence started with 1...)
    1 10 1001 10010110 1001011001101001 ...

"Characterization using bitwise negation

The Thueâ€“Morse sequence in the form given above, as a sequence of bits, 
can be defined recursively using the operation of bitwise negation. So, the 
first element is 0. Then once the first 2n elements have been specified, 
forming a string s, then the next 2n elements must form the bitwise negation of 
s. Now we have defined the first 2n+1 elements, and we recurse.

Spelling out the first few steps in detail:

    * We start with 0.
    * The bitwise negation of 0 is 1.
    * Combining these, the first 2 elements are 01.
    * The bitwise negation of 01 is 10.
    * Combining these, the first 4 elements are 0110.
    * The bitwise negation of 0110 is 1001.
    * Combining these, the first 8 elements are 01101001.
    * And so on.
So the sequence is
    * T0 = 0
    * T1 = 01
    * T2 = 0110
	...
    
Define a function 'thue' which given the nth thue element returns
the next thue element.  The elements will be represented as a list of 0s and 1s.
You must use a primitive recursive function in your definition.

Example:
...> thue [0,1,1,0]
[0,1,1,0,1,0,0,1]


Problem 9 Answer:
Note: you may have a slightly different type depending on your solution.

> thue :: (Eq a, Num a, Num a1) => [a] -> [a1]
> thue :: (Eq a, Num a, Num a1) => [a] -> [a1]
> thue [] = []
> thue (0:tail) = [0] ++ [1] ++ thue(tail)
> thue (1:tail) = [1] ++ [0] ++ thue(tail)

> thue lst = secondary lst lst
> secondary [] lst = lst
> secondary (head:tail) lst
>	| head == 0 = (secondary tail lst) ++ [1]
>	| otherwise = (secondary tail lst) ++ [0]


Problem 10:
Define a function replicate' which given a list of numbers returns a 
list with each number duplicated its value. The ' is not a typo - this is to
avoid the existing replicate.
Use primitive recursion in your definition.
My solution used a nested helper function.
Example:
...> replicate' [2, 4, 1]
[2,2,4,4,4,4,1]
...> replicate' [1,0,2,1]
[1,2,2,1]

Problem 10 Answer:

> replicate' :: (Eq a, Num a) => [a] -> [a]
> helper :: (Eq a, Num a) => a -> a -> [a]
> replicate' [] = []
> replicate' (head:tail) = (helper head head) ++ (replicate' tail)
> helper head numTimes --implementation of the helper function
>		| numTimes == 0 = []
>		| otherwise = [head] ++ (helper head (numTimes - 1))
