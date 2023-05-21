module Main where

isSingleton :: [x] -> Bool
isSingleton [_] = True
isSingleton _ = False

-- | A value with explicitly separated computation steps.
data Iter a
  = Done a -- ^ Final (computed) value.
  | Step (Iter a) -- ^ A computation that requires at least one more step.
  deriving (Show) -- for printing

factorialIter :: Int -> Iter Int
factorialIter = go 1
  where
    go current n
      | n <= 1 = Done current
      | otherwise = Step (go (n * current) (n - 1))

--Exercise 1
insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys)
  | x <= y = x : y : ys 
  | otherwise = y : insert x ys 

--Exercise 2
approximate
  :: (a -> Bool) -- ^ Is current approximation good enough?
  -> (a -> a) -- ^ Improve current approximation.
  -> a -- ^ Initial approximation.
  -> Iter a
approximate stop next x
  | stop x = Done x
  | otherwise = Step (approximate stop next (next x))

--Exercise 3.a
eval :: Iter a -> a
eval (Done x) = x
eval (Step i) = eval i

--Exercise 3.b
limit :: Int -> Iter a -> Iter (Maybe a)
limit _ (Done x) = Done (Just x)
limit 0 _ = Done Nothing
limit n (Step i) = Step (limit (n - 1) i)

--Exercise 3.c
partialEval :: Int -> Iter a -> Iter a
partialEval n (Step i)
  | n > 0 = partialEval (n - 1) i
partialEval _ i = i

--Exercise 3.d
steps :: Iter a -> Int
steps (Done _) = 0
steps (Step i) = 1 + steps i

--Exercise 4.a
mapIter :: (a -> b) -> Iter a -> Iter b
mapIter f (Done x) = Done (f x)
mapIter f (Step i) = Step (mapIter f i)

--Exercise 4.b
joinIter :: Iter (Iter a) -> Iter a
joinIter (Done x) = x
joinIter (Step i) = Step (joinIter i)

--Exercise 5
insertIter :: Int -> [Int] -> Iter [Int]
insertIter x [] = Done [x]
insertIter x (y:ys) = Step next
  where
    next
      | x > y = mapIter (y :) (insertIter x ys)
      | otherwise = Done (x : y : ys)

--Exercise 6
insertionSortIter :: [Int] -> Iter [Int]
insertionSortIter [] = Done []
insertionSortIter (x:xs) = joinIter
  (mapIter (insertIter x) (insertionSortIter xs))

            
main :: IO ()
main = do
  print(insert 3 [1,2,5,7])
  -- [1,2,3,5,7]
  print(insert 3 [0,1,1])
  -- [0,1,1,3]
  print(take 5 (insert 3 [1..]))
  -- [1,2,3,3,4]
  print(approximate (\x -> x^2 < 1) (/ 2) 3)
  -- Step (Step (Done 0.75))
  print(approximate (\x -> x^2 < 0.01) (/ 2) 3)
  -- Step (Step (Step (Step (Step (Done 9.375e-2)))))
  print(approximate isSingleton (drop 1) [1..3])
  -- Step (Step (Done [3]))
  print(eval (approximate (\x -> x^2 < 0.01) (/ 2) 10))
  -- 7.8125e-2
  print(limit 100 (approximate (\x -> x^2 < 0.01) (/ 2) 3))
  -- Step (Step (Step (Step (Step (Done (Just 9.375e-2))))))
  print(limit 3 (approximate (\x -> x^2 < 0.01) (/ 2) 3))
  -- Step (Step (Step (Done Nothing)))
  print(limit 0 (approximate (\x -> x^2 < 0.01) (/ 2) 3))
  -- Done Nothing
  print(partialEval 100 (approximate (\x -> x^2 < 0.01) (/ 2) 3))
  -- Done 9.375e-2
  print(partialEval 3 (approximate (\x -> x^2 < 0.01) (/ 2) 3))
  -- Step (Step (Done 9.375e-2))
  print(steps (approximate (\x -> x^2 < 0.01) (/ 2) 3))
  -- 5
  print(mapIter (+1) (Done 3))
  -- Done 4
  print(mapIter (+1) (Step (Step (Done 3))))
  -- Step (Step (Done 4))
  print(joinIter (Step (Done (Step (Done 3)))))
  -- Step (Step (Done 3))
  print(insertIter 1 [2, 3])
  -- Step (Done [1,2,3])
  print(insertIter 4 [2, 3])
  -- Step (Step (Done [2,3,4]))
  print(insertionSortIter [1..4])
  -- Step (Step (Step (Done [1,2,3,4])))
  print(insertionSortIter [4,3..1])
  -- Step (Step (Step (Step (Step (Step (Done [1,2,3,4]))))))
  print(steps (insertionSortIter [1..10]))
  -- 9
  print(steps (insertionSortIter [10,9..1]))
  -- 45
  
  