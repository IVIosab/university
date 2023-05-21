module Main where

--Exercise 1.a
isSingleton :: [x] -> Bool
isSingleton [_] = True
isSingleton _ = False

--Exercise 1.b
insert :: Int -> [Int] -> [Int]
insert x [] = [x]
insert x (y:ys) 
  | x <= y = x:y:ys
  | otherwise = y:insert x ys

--Exercise 1.c
separateBy :: x -> [x] -> [x]
separateBy _ [] = []
separateBy _ [x] = [x]
separateBy separator (x:xs) = x : separator : separateBy separator xs

--Exercise 1.d
splitWhenNot :: (x -> Bool) -> [x] -> ([x], [x])
splitWhenNot _ [] = ([], [])
splitWhenNot p (x:xs)
  | p x = (x : before, after)
  | otherwise = ([], x:xs)
  where
    (before, after) = splitWhenNot p xs


--Exercise 1.e
groupsSeparatedBy :: (x -> Bool) -> [x] -> [[x]]
groupsSeparatedBy _ [] = []
groupsSeparatedBy p xs =
  case splitWhenNot (not . p) xs of
    ([], after) -> groupsSeparatedBy p (dropWhile p after)
    (before, after) -> before : groupsSeparatedBy p (dropWhile p after)

--Exercise 1.f
replicateWithPos :: [x] -> [x]
replicateWithPos xs = concat (zipWith replicate [1..] xs)

--Exercise 2.a
lucas :: [Int]
lucas = helper 2 1
  where
    helper x y = x : helper y (x + y)

--Exercise 2.b
approximationsOfRoot2 :: Double -> [Double]
approximationsOfRoot2 = iterate helper
  where
    helper x = x - x/2 + 1/x

            
main :: IO ()
main = do
  print(isSingleton [1])
  -- True
  print(isSingleton [1..])
  -- False
  print(isSingleton [[1..]])
  -- True
  print(insert 3 [1,2,5,7])
  -- [1,2,3,5,7]
  print(insert 3 [0,1,1])
  -- [0,1,1,3]
  print(take 5 (insert 3 [1..]))
  -- [1,2,3,3,4]
  print(separateBy ',' "hello")
  -- "h,e,l,l,o"
  print(take 5 (separateBy 0 [1..]))
  -- [1,0,2,0,3]
  print(splitWhenNot (/= ' ') "Hello, world!")
  -- ("Hello,"," world!")
  print(take 10 (fst (splitWhenNot (< 100) [1..])))
  -- [1,2,3,4,5,6,7,8,9,10]
  print(take 10 (snd (splitWhenNot (< 100) [1..])))
  -- [100,101,102,103,104,105,106,107,108,109]
  print(take 10 (fst (splitWhenNot (> 0) [1..])))
  -- [1,2,3,4,5,6,7,8,9,10]
  print(groupsSeparatedBy (== ' ') "Here are some words!")
  -- ["Here","are","some","words!"]
  print(take 3 (groupsSeparatedBy (\n -> n `mod` 4 == 0) [1..]))
  -- [[1,2,3],[5,6,7],[9,10,11]]
  print(replicateWithPos [1..3])
  -- [1,2,2,3,3,3]
  print(replicateWithPos "Hello")
  -- "Heelllllllooooo"
  print(take 10 (replicateWithPos [1..]))
  -- [1,2,2,3,3,3,4,4,4,4]
  print(take 10 lucas)
  -- [2,1,3,4,7,11,18,29,47,76]
  print(take 5 (approximationsOfRoot2 1))
  -- [1.0,1.5,1.4166666666666665,1.4142156862745097,1.4142135623746899]
  