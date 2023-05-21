{-# OPTIONS_GHC -Wall #-}
module Main where
import Data.Char (toUpper)

--exercise 1
guess :: (a -> Bool) -> (String -> IO a) -> IO a
guess p g = do
    s <- getLine
    x <- g s
    case p x of
        True -> return x
        False -> guess p g
-- getLine :: IO String
-- s :: String
-- g :: String -> IO a
-- x :: a
-- p :: a -> Bool
-- p x :: Bool
-- return :: (b -> IO b)
-- return x :: IO a

--exercise 2 
echo :: IO ()
echo = do
    line <- getLine
    putStrLn (map toUpper line)
    echo

--exercise 3.a
foreverIO :: IO a -> IO b
foreverIO x = do
    _ <- x
    foreverIO x

--exercise 3.b
whenIO :: Bool -> IO () -> IO () 
whenIO cond x = do
    case cond of 
        True -> x
        False -> putStrLn "Condition is not satisfied"

--exercise 3.c
maybeIO :: Maybe (IO a) -> IO (Maybe a) 
maybeIO Nothing = return Nothing
maybeIO (Just x) = do
    y <- x
    return (Just y)

--exercise 3.d
sequenceMaybeIO :: [IO (Maybe a)] -> IO [a]  
sequenceMaybeIO (x:xs) = do
    y <- x
    rest <- sequenceMaybeIO xs
    case y of 
        Just z -> return (z:rest)
        Nothing -> sequenceMaybeIO xs

--exercise 3.e
whileJustIO :: (a -> IO (Maybe a)) -> a -> IO ()
whileJustIO f x = do
    y <- (f x)
    case y of 
        Just z -> whileJustIO f z
        Nothing -> return ()

--exercise 3.f
forStateIO_ :: s -> [a] -> (a -> s -> IO s) -> IO s
forStateIO_ state [] _ = return state
forStateIO_ state (x:xs) f = do
    y <- (f x state)
    z <- forStateIO_ y xs f 
    return z

verboseCons :: Int -> [Int] -> IO [Int]
verboseCons x xs = do
    putStrLn ("prepending " ++ show x ++ " to " ++ show xs)
    return (x:xs)

--exercise 4
iforIO_ :: [a] -> (a -> IO ()) -> IO ()
iforIO_ [] _ = return ()
iforIO_ (x:xs) f = do
    f x
    iforIO_ xs f
            
main :: IO ()
main = echo


