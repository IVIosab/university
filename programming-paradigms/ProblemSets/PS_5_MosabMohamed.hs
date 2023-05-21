{-# OPTIONS_GHC -Wall #-}
import CodeWorld

--exercise 1.a
binaryToDecimal :: [Int] -> Int
binaryToDecimal [] = 0
binaryToDecimal bits = helper 0 0 (reverse bits)
  where
    helper _index decimal [] = decimal
    helper index decimal (bit:morebits) = helper (index+1) (decimal+(bit*(2^index))) morebits


--exercise 1.b
firstZeros :: [Int] -> Int
firstZeros [] = 0
firstZeros (0:bits) = 1 + (firstZeros bits)
firstZeros (_bit:_bits) = 0

allZeros :: [Int] -> Int
allZeros [] = 0
allZeros (0:bits) = 1 + (allZeros bits)
allZeros (_bit:bits) = 0 + (allZeros bits)

countZeros :: [Int] -> Int
countZeros lst = allZeros lst - firstZeros lst

--exercise 1.c
removeBits :: ([Int], Int) -> [Int]
removeBits (bits, 0) = bits
removeBits ((_bit:bits), x) = removeBits (bits, x-1)

encodeWithLengths :: [Int] -> [Int]
encodeWithLengths bits = helper (removeBits (bits, (firstZeros bits))) 1 0 []
  where
    helper [] _prv cnt cur =  (reverse (cnt:cur))
    helper (0:rest) 0 cnt cur = (helper (rest) (0) (cnt+1) (cur))
    helper (0:rest) 1 cnt cur = (helper (rest) (0) (1) (cnt:cur))
    helper (1:rest) 0 cnt cur = (helper (rest) (1) (1) (cnt:cur))
    helper (1:rest) 1 cnt cur = (helper (rest) (1) (cnt+1) (cur))
    
--exercise 1.d
binaryOdd :: [Int] -> Bool
binaryOdd bits = (odd (binaryToDecimal bits)) 

--exercise 1.e
decrement :: [Int] -> [Int]
decrement bits = helper (reverse (removeBits (bits, (firstZeros bits)))) [] 0 (length bits)
  where 
    helper [] current 0 _len = [0]
    helper [] current _flag _len = current
    helper (0:rest) current 0 len = (helper (rest) (1:current) (0) (len-1))
    helper (bit:rest) current 0 1 = (helper (rest) (current) (1) (0))
    helper (bit:rest) current 0 len = (helper (rest) (0:current) (1) (len-1))
    helper (1:rest) current 1 len = (helper (rest) (1:current) (1) (len-1))
    helper (bit:rest) current 1 len = (helper (rest) (0:current) (1) (len-1))

--exercise 1.f
propagate :: (Bool, [Int]) -> [(Bool, Int)]
propagate (b, []) = []
propagate (b, x:xs) = (b, x) : propagate (b, xs)

--exercise 2.a
alternatingSum :: [Int] -> Int
alternatingSum [] = 0
alternatingSum (first:[]) = first
alternatingSum (first:(second:rest)) = (((first)+((-1)*second)) + (alternatingSum rest))

--exercise 2.b
--alternatingSum [1,2,3,4,5]
-- = (((first)+((-1)*second)) + (alternatingSum rest))
--      where first = 1, second = 2, rest = [3,4,5]
-- = ((1 + ((-1) * 2)) + (alternatingSum [3,4,5])) 
-- = ((1 + ((-1) * 2)) + ((((first)+((-1)*second)) + (alternatingSum rest)))
--                     where first = 3, second = 4, rest = [5]
-- = ((1 + ((-1) * 2)) + (((3 + ((-1) * 4)) + (alternatingSum [5])))
-- = ((1 + ((-1) * 2)) + (((3 + ((-1) * 4)) + (first)))
--                                       where first = 5
-- = ((1 + ((-1) * 2)) + (((3 + ((-1) * 4)) + 5)))
-- = ((1 + (-2)) + (3 + (-4) + 5))
-- = ((-1) + (-1) + 5)
-- = ((-2) + 5)
-- = 3



--exercise 3
data Radians = Radians Double
data Degrees = Degrees Double

pI :: Double --please note the name "pI" instead of "pi" to avoid ambiguity between our defintion and Prelude.pi 
pI = 3.14159

toDegrees :: Radians -> Degrees
toDegrees (Radians x) = Degrees (x * 180 / pI)

fromDegrees :: Degrees -> Radians
fromDegrees (Degrees x) = Radians (x * pI / 180)

main :: IO ()
main = print (decrement [0] )


