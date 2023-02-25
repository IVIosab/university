module Main where

type Name = String
data Grade = A | B | C | D
data Student = Student Name Grade

data Result a
    = Success a
    | Failure String


--exercise 1
dup :: (a -> a -> b) -> a -> b
dup f x = f x x

dip :: (t -> t -> t) -> t -> t -> t
dip f x = f (f x x)

twice :: (t -> t) -> t -> t
twice f x = f (f x)


--exercise 1.a
--dip (+) 1 2
--dip :: (t -> t -> t) -> t -> t -> t
--(+) :: Int -> Int -> Int
--1 :: Int
--2 :: Int
--(t -> t -> t) = (Int -> Int -> Int)
--t = Int 
--t = Int
--dip :: (t -> t -> t) -> t -> t -> t = (Int -> Int -> int) -> Int -> Int
--Therefore, 
--dip (+) 1 2 :: Int


--exercise 1.b
-- dup (dip (+)) 1
--dup :: (a -> a -> b) -> a -> b
--dip :: (t -> t -> t) -> t -> t -> t
--(+) :: Int -> Int -> Int
--1 :: Int
--(t -> t -> t) = (Int -> Int -> Int)
--t = Int
--(dip (+)) :: Int -> Int -> Int
--(a -> a -> b) = (Int -> Int -> Int)
--a = Int
--b = Int
--dup :: (Int -> Int -> Int) -> Int -> Int
--Therefore, 
--dup (dip (+)) 1 :: Int


--exercise 1.c
--twice dip 
--twice :: (a -> a) -> a -> a
--dip :: (t -> t -> t) -> t -> t -> t
--(a -> a) = (t -> t -> t) -> t -> t -> t
--(t -> t -> t) -> t -> t -> t = (t -> t -> t) -> (t -> t -> t)
--a = (t -> t -> t)
--Therefore, 
--twice dip :: (t -> t -> t) -> (t -> t -> t)


--exercise 1.d
--dip dip
--dip :: (t -> t -> t) -> t -> t -> t
--(t -> t -> t) = ((t1 -> t1 -> t1) -> t1 -> t1 -> t1)
--t = (t1 -> t1 -> t1)
--t = t1 -> t1
--t = t1
--contradiction: t1 = (t1 -> t1) = (t1 -> t1 -> t1)
--Therefore,
--dip dip :: type error


--exercise 1.e
--twice twice twice
--twice :: (a -> a) -> a -> a
--(a -> a) = ((a1 -> a1) -> a1 -> a1)
--a = (a1 -> a1)
--(a1 -> a1) = ((a2 -> a2) -> a2 -> a2)
--a1 = (a2 -> a2)
--a = ((a2 -> a2) -> a2 -> a2)
--Therefore, 
--twice twice twice :: (a2 -> a2) -> a2 -> a2


--exercise 1.f
-- dup twice
--dup :: (a -> a -> b) -> a -> b
--twice :: (t -> t) -> t -> t
--(a -> a -> b) = ((t -> t) -> t -> t)
--a = (t -> t)
--a = t 
--b = t
--contradiction: t = (t -> t)
--Therefore,
--dup twice :: type error


--exercise 2
studentsWithA :: [Student] -> [Name]
studentsWithA [] = []
studentsWithA ((Student name A):ss) = name : studentsWithA ss
studentsWithA ((Student _name _grade):ss) = studentsWithA ss


--exercise 3.a
whileSuccess :: (a -> Result a) -> a -> a
whileSuccess f x = go (f x)
    where
        go (Success y) = go (f y)
        go (Failure _) = x


--exercise 3.b
applyResult :: Result (a -> b) -> Result a -> Result b
applyResult (Failure e1) _ = Failure e1 
applyResult _ (Failure e2) = Failure e2
applyResult (Success f) (Success x) = Success (f x)  

--exercise 3.c
fromResult :: (a -> b) -> (String -> b) -> Result a -> b
fromResult f1 _ (Success x) = f1 x
fromResult _ f2 (Failure e) = f2 e


--exercise 3.d
combineResultsWith :: (a -> b -> c) -> Result a -> Result b -> Result c
combineResultsWith _ (Failure e1) _ = (Failure e1)
combineResultsWith _ _ (Failure e2) = (Failure e2)
combineResultsWith op (Success x) (Success y) = (Success (op x y))


main :: IO ()
main = print 5    
