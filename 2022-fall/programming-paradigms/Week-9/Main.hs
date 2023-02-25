module Main where


exercise_6_1_a :: Integer
exercise_6_1_a = 2 + 3
exercise_6_1_b :: Floating a => (a, a) -> a
exercise_6_1_b (x, y) = sqrt (x^2 + y^2)
exercise_6_1_c :: a -> a -> [a]
exercise_6_1_c x y = [x, y]
exercise_6_1_d :: [Char] -> [Char]
exercise_6_1_d [] = ""
exercise_6_1_d (x:xs) = exercise_6_1_d xs ++ [x]
exercise_6_1_e :: b -> (b, b)
exercise_6_1_e x = (x, x)


data Cartesian = Cartesian Double Double 
data Radians = Radians Double
data Polar = Polar Double Radians 

toPolar :: Cartesian -> Polar 
toPolar (Cartesian x y) = (Polar a (Radians b))
    where
        a = sqrt(x^2+y^2)
        b = y/x

fromPolar :: Polar -> Cartesian
fromPolar (Polar x (Radians y)) = (Cartesian a b)
    where 
        a = x*cos(y)
        b = x*sin(y)
        



main :: IO ()
main = do 
    print(5)
    print(12)