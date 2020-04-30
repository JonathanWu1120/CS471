Jonathan Wu
> module Hw13
>    where

Please rename this file to "Hw13.lhs".
Add your code to this file in the positions indicated with "Problem N Answer:".


Problem 1: Find operators (that can be partially applied), sec1 and sec2, so that
  map sec1 . filter sec2
has the same effect as
  filter (>0) . map (+1)

Problem 1 Answer:

> s4 = map (+1) . filter(> (-1))
	
Problem 2: In a previous assignment, you used primitive recursion to define a
function composeList. composeList took a list of functions and composed them
into a single function. 

   ... >composeList [ (-) 3 , (*) 2, (+)5 ] 7
       -21


One possible solution is 

> composeList :: [(a -> a)] -> a -> a
> composeList [] = id
> composeList (h:t) = (.) h (composeList t)

Define composeHOF to be equivalent to composeList but use a fold,
You will need to specify the type of composeHOF; you can use the type provided.

Problem 2 Answer:

> composeHOF :: Foldable t => t (b -> b) -> b -> b
> composeHOF = (\list -> foldr1 (.) list)


Problem 3: The harmonic series is the following infinite series:
                            1   1   1   1               1
                      1 +   - + - + - + - + ...   + ... - ..
                            2   3   4   5               i
(http://en.wikipedia.org/wiki/Harmonic_series_(mathematics))
In a previous assignment you defined a function sumHarmonic such that
sumHarmonic i is the sum of the first in terms of this series. For example,
sumHarmonic 4 ~> 1 + 1 + 1 + 1 ~> 2.08333...
                     2   3   4

In the last assignment you defined sumHarmonic using a simple recursive style.  
One possible solution is

> sumHarmonic :: (Eq a, Fractional a) => a -> a
> sumHarmonic 1 = 1
> sumHarmonic n = 1 / n + sumHarmonic (n-1)

Define sumH to be equivalent to sumHarmonic using either foldr or foldl.
Use the following template where ??? should be a lamdba expression that
accumulates the values.
  sumH n = foldr ??? 0 [1..n]
or 
  sumH n = foldl ??? 0 [1..n]
  
   ...> sumHarmonic 20
   3.59773965714368

Problem 3 Answer:

> sumH n = foldl (\acc x -> acc + 1/x) 0 [1..n]



Problem 4: In a previous assignment, you wrote a function to create the 
next value in the Thue-Morse sequence.  Below is one possible solution.

> thue (s:sx) = s : (mod (s+1)  2): thue sx
> thue [ ] = [ ]

Using the circular list idea demostrated in fibSeq
  (http://bingweb.binghamton.edu/%7Ehead/CS471/NOTES/HASKELL/4hF02.html)
Define thueSeq to be a sequence of thue values. You should use list
comprehension. You may use the 'thue' definition from your homework or the
solution provided above.  You may assume the sequence starts with "0".

For example:
   > take 4 thueSeq
   > [[0],[0,1],[0,1,1,0],[0,1,1,0,1,0,0,1]]

Problem 4 Answer:
  
> thueSeq :: [[Integer]]
> thueSeq = [0] : [thue temp | temp <-thueSeq]
   

Problem 5: Define thueSeqMap to be equivalent to thueSeq but using map
instead of list comprehension.

Problem 5 Answer:

> thueSeqMap = [0] : [temp | temp <- map thue thueSeqMap]


Problem 6:
Using an HOF (map, fold and/or filter ) define a function that takes a list of pairs
and returns a list containing the values.

   ...> flattenT [(a,b), (x,y), (g,g)]
   [a,b,x,y,g,g]

 6a) Define flattenT such that the output is in the same order as the values
 appear in the original list.

   ...> flattenT  [(1,2), (3,4), (11,21),(-5,45)] 
   [1,2,3,4,11,21,-5,45]


 6b) Define flattenR such that the output is in the REVERSE order from the
 original list. Do NOT use the builtin reverse. 
 
   ...> flattenR  [(1,2), (3,4), (11,21),(-5,45)] 
   [45,-5,21,11,4,3,2,1]

Problem 6 Answer:

> flattenT :: Foldable t => t (a, a) -> [a]
> flattenT lst = foldl (\acc(a,b) -> acc ++[a]++[b]) [] lst

> flattenR :: Foldable t => t (a, a) -> [a]
> flattenR lstTwo = foldl (\acc(a,b) -> [b] ++ [a] ++ acc) [] lstTwo


Problem 7: An inductive definition of a binary tree and a pretty print function 
was provided in a previous assignment (repeated below).

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


If 'Tree a' is a BST (binary search tree) then 'tree_search' returns True 
if v (value) is a member of the "Tree a"

> tree_search :: Ord a => Tree a -> a -> Bool
> tree_search Nil v = False
> tree_search (Node e l r) v
>  | v == e    = True
>  | v < e     = tree_search l v
>  | v > e     = tree_search r v

'tree_insert', defined below, inserts a value into a BST and
maintances the BST invariant.  Below you see a new operator, "@". 
Using "@", pronounced 'as', it is possible to label all or part of an argument.
So we can use 'nd' on line 226 (5 lines below) instead of 'Node e l r'.  

> tree_insert :: Ord a => Tree a -> a -> Tree a
> tree_insert Nil v = (Node v Nil Nil)
> tree_insert nd@(Node e l r) v
>  | v == e    = nd  
>  | v < e     = (Node e (tree_insert l v) r)
>  | v > e     = (Node e l (tree_insert r v))

Provided below are a few default binary search trees so you do not need to keep
entering them into ghci.

> tree1 = (Node 5 (Node 2 (Node 1 Nil Nil) (Node 3 Nil Nil)) (Node 7 Nil (Node 9 Nil Nil)))
> tree2 = (Node 5 (Node 2 (Node 1 Nil Nil) Nil) (Node 7 Nil (Node 9 Nil Nil)))
> tree3 = (Node 5 (Node 2 (Node (-1) (Node (-3) Nil Nil) Nil) Nil) (Node 7 Nil (Node 9 Nil Nil)))

Using our inductive definition of a Tree define a function
"tree_fold f acc tree" that folds all the values of a tree inorder using f.
This should involve performing an inorder traversal of the tree,
accumulating (combining) values along the way.

   Here is a rough sketch of the algorithm to help you get started:
    (0) tree_fold f acc Nil = acc (returns the combination thus far)
    (1) tree_fold f acc (Node v l r) =
       (a) Recurse on the left, getting a new accumulated value
       (b) Perform the accumulating operation (f) on the current value (v) 
           and the returned value from (a)
       (c) Recurse on the right, passing the new accumulated value from (b) 

Problem 7 Answer:

> tree_fold :: (a -> b -> a) -> a -> Tree b -> a
> tree_fold operation acc Nil = acc
> tree_fold operation acc (Node v l r) = tree_fold operation (tree_fold operation ((operation) acc v) l) r

Problem 8: To demonstrate the computational power of tree_fold, write a function
'inorder_list tree' that uses tree_fold to build a list of all the elements 
of tree in order. Since the tree_fold recurses inorder, all you simply need to
think about is the lambda that should build the list.

Problem 8 Answer:

> inorder_list :: Tree a -> [a]
> inorder_list (Node v l r) = tree_fold (\x y -> x++[y]) [] (Node v l r)


Problem 9: Define a function merge that takes two lists where all the
elements are unique and in increasing order, then returns a single list
with all the elements of both still in increasing order.

   ...> merge [1,3,5] [2,4,6]
   [1,2,3,4,5,6]
   ...> merge [1,2,3] [4,5,6]
   [1,2,3,4,5,6]

Problem 9 Answer:
> merge (head1:tail1) (head2:tail2)
>   | head1 == head2  = head1 : merge tail1 tail2
>   | head1 < head2   = head1 : merge tail1 (head2:tail2)
>   | head1 > head2   = head2 : merge (head1:tail1) tail2
> merge [] list2 = list2 
> merge list1 []  = list1 


Problem 10:  (Thompson 17.24/30 )
Define the list of numbers whose only prime factors are 2, 3, and 5, the
so-called Hamming numbers:

   ...> hamming
   1,2,3,4,5,6,8,9,10,12,15,16,18,20,24 ...


 You may consider using any combinition of the following techiques
       to express your solution  list comprehension notation, 
       and/or explicit recursion, and/or local definitions .  
       'merge', which you previously defined, may be useful.

(Hint: Apply the circular list idea demostrated in fibSeq
  (http://bingweb.binghamton.edu/%7Ehead/CS471/NOTES/HASKELL/4hF02.html)) 

Problem 10 Answer:

> hamming = 1 : merge (map (2*) hamming) (merge (map (3*) hamming) (map (5*) hamming))
