{-# OPTIONS_GHC -Wall #-}
-- Task:
-- implement the tools for working with discrete lines and discrete 2D spaces 
-- with a point (cell) in focus. You can think of a discrete line as a tape 
-- (e.g., like one used in Turing machine)

module Main where
import CodeWorld

--------------------------------------------------------------------------------
-- Lines 
-- A discrete line consists of a point (cell) in focus and a (possibly infinite) 
-- list of cells to the left and to the right of it

-- | A line with a focus.
-- Line xs y zs represents a descrete line:
-- * xs represents all elements to the left (below)
-- * y is the element in focus
-- * zs represents all elements after (above)
data Line a = Line [a] a [a]
  deriving (Show) -- required to enable printing (for finite lines)

-- | A line of integers with focus at 0.
integers :: Line Integer
integers = Line [-1, -2..] 0 [1, 2..]


-- Exercise 1.1
-- | Keep up to a given number of elements in each direction in a line.
-- cutLine 3 integers = Line [-1,-2,-3] 0 [1,2,3]
cutLine :: Int -> Line a -> Line a
cutLine n (Line xs y zs) = Line (take n xs) y (take n zs)
--- >>> cutLine 5 integers 
-- Line [-1,-2,-3,-4,-5] 0 [1,2,3,4,5]

-- Exercise 1.2
-- | Mainly for testing purposes 
-- Takes a boolean function, and a function, and an argument
-- applies the second function to the third argument if 
-- the third argument returns true when applied to the boolean function
-- otherwise returns nothing
applyIf :: (a -> Bool) -> (a -> b) -> a -> Maybe b
applyIf p f x
  | p x       = Just (f x)
  | otherwise = Nothing


-- | Generate a line by using generating functions.
-- (genLine f x g) generates a line with x in its focus,
-- then it applies f to x until reaching Nothing to produce
-- a list of elements to the left of x,
-- and, similarly, applies g to x until reaching Nothing to
-- produce a list of elements to the right of x.
genLine :: (a -> Maybe a) -> a -> (a -> Maybe a) -> Line a
genLine f x g = Line (helper f (f x)) x (helper g (g x))
  where
        helper _ Nothing = []
        helper fg (Just a) = a : helper fg (fg a)
-- >>> genLine (applyIf (> -3) (subtract 1)) 0 (applyIf (< 3) (+1))
-- Line [-1,-2,-3] 0 [1,2,3]
-- >>> genLine (\_ -> Nothing) 1 (\_ -> Nothing)
-- Line [] 1 []
-- >>> cutLine 3 (genLine Just 0 Just)
-- Line [0,0,0] 0 [0,0,0]

-- Exercise 1.3
-- | Apply a function to all elements on a line.
-- mapLine (^2) integers = Line [1, 4, 9, ..] 0 [1, 4, 9, ..]
mapLine :: (a -> b) -> Line a -> Line b
mapLine f (Line xs y zs) = Line (map f xs) (f y) (map f zs)
-- >>> mapLine (^2) (cutLine 5 integers)
-- Line [1,4,9,16,25] 0 [1,4,9,16,25]

-- Exercise 1.4
-- | Zip together two lines.
-- zipLines integers integers
-- = Line [(-1,-1),(-2,-2),..] (0,0) [(1,1),(2,2),..]
zipLines :: Line a -> Line b -> Line (a, b)
zipLines (Line xs y zs) (Line as b cs) = Line (zip xs as) (y, b) (zip zs cs)
-- >>> zipLines (cutLine 5 integers) (cutLine 5 integers)
-- Line [(-1,-1),(-2,-2),(-3,-3),(-4,-4),(-5,-5)] 
--      (0,0) 
--      [(1,1),(2,2),(3,3),(4,4),(5,5)]

-- | Zip together two lines with a given combining function.
-- zipLinesWith (*) integers integers
-- = Line [1,4,9,..] 0 [1,4,9,..]
zipLinesWith :: (a -> b -> c) -> Line a -> Line b -> Line c
zipLinesWith f (Line xs y zs) (Line as b cs) = 
  Line (zipWith f xs as) (f y b) (zipWith f zs cs)
-- >>> zipLinesWith (*) (cutLine 5 integers) (cutLine 5 integers)
-- Line [1,4,9,16,25] 0 [1,4,9,16,25]

--------------------------------------------------------------------------------
-- Rule 30
-- implement Rule 30 cellular automaton1 using our definition of discrete lines.

-- | A cell with state
-- state is either alive or dead
data Cell = Alive | Dead
  deriving (Show)  -- required to enable printing (for finite lines)
    
-- | Render cell in code world 
-- if alive renders a black square 
-- otherwise renders a white square with black outline
renderCell :: Cell -> Picture
renderCell Alive = solidRectangle 1 1
renderCell Dead = rectangle 1 1

-- | Parses cell to boolean value
-- if alive returns True
-- otherwise returns False
-- Exercise 1.5
cellToBool :: Cell -> Bool
cellToBool Alive = True
cellToBool Dead  = False

-- | Parses boolean value to cell
-- if True returns Alive
-- otherwise returns Dead
boolToCell :: Bool -> Cell
boolToCell True  = Alive
boolToCell False = Dead

-- | Gets the first cell of a cell list 
-- if list is empty retuns Dead because we assume infinte number of dead cells
-- otherwise returns first of list
checkList :: [Cell] -> Cell
checkList [] = Dead
checkList (Alive:_) = Alive
checkList (Dead:_) = Dead

-- | Applies rule30 to a line cell
-- computes the next state with the following formula
-- (left cell) XOR ((middle cell) OR (right cell))
rule30 :: Line Cell -> Cell
rule30 (Line left mid right) = boolToCell (left' /= (mid' || right'))
  where
    left' = cellToBool (checkList left)
    right' = cellToBool (checkList right)
    mid' = cellToBool mid
-- >>> rule30 (Line [Alive] Alive [Alive])
-- Dead
-- >>> rule30 (Line [Dead] Alive [Alive])
-- Alive
-- >>> rule30 (Line [Alive] Dead [Dead])
-- Alive
-- >>> rule30 (Line [Dead, Alive, Alive] Alive [Alive, Alive, Alive])
-- Alive
-- >>> rule30 (Line [Alive, Alive, Alive] Alive [Alive, Alive, Alive])
-- Dead

-- Exercise 1.6
-- | Shift focus of a line one cell to the left
shiftLeft :: Line a -> Maybe (Line a)
shiftLeft (Line [] _ _) = Nothing 
shiftLeft (Line (x:xs) y zs) = Just (Line xs x (y:zs)) 
-- >>> shiftLeft (Line [0,1,1] 1 [1,1,1])
-- Just (Line [1,1] 0 [1,1,1,1])

-- | Shift focus of a line one cell to the right
shiftRight :: Line a -> Maybe (Line a)
shiftRight (Line _ _ []) = Nothing
shiftRight (Line xs y (z:zs)) = Just (Line (y:xs) z zs)
-- >>> shiftRight (Line [0,1,1] 1 [1,1,1])
-- Just (Line [1,0,1,1] 1 [1,1])

-- Exercise 1.7
-- | Produces a line of lines by having the original line in focus
-- and shifting the focus in the original line to the left 
-- and to the right to get lists of lines where each cell
-- can be a focus
lineShifts :: Line a -> Line (Line a)
lineShifts line = genLine shiftLeft line shiftRight
-- >>> lineShifts (Line [2,1] 3 [4,5])
-- Line [Line [1] 2 [3,4,5],Line [] 1 [2,3,4,5]] 
--      (Line [2,1] 3 [4,5]) 
--      [Line [3,2,1] 4 [5],Line [4,3,2,1] 5 []]

-- | Applies rule30 to every cell in a line of cells 
-- gets all lines with different focuses with lineShifts
-- returns a line of cells with the new cells by applying 
-- rule30 on each line 
applyRule30 :: Line Cell -> Line Cell
applyRule30 line = mapLine rule30 (lineShifts line)
-- >>> applyRule30 (Line [Alive, Dead] Alive [Alive, Dead])
-- Line [Alive,Alive] Dead [Dead,Alive]

-- Exercise 1.8
-- | Renders a list of pictures in a single picture
-- given an operator to define the translation shift for each picture
renderPictures :: [Picture] -> (Double -> Double) -> Picture
renderPictures [] _ = blank
renderPictures (p:ps) op = left <> right
  where
    left = translated (op 1) 0 p 
    right = translated (op 1) 0 (renderPictures ps op)

-- | Render a line of 1x1 pictures.
-- by rendering the focus, then applying renderPictures to 
-- left list and right list of pictures with (*(-1)) and (*1) operators
-- to specify translation shift
renderLine :: Line Picture -> Picture
renderLine (Line xs y zs) = (renderPictures xs (*(-1))) 
           <> y 
           <> (renderPictures zs (*1)) 
    
-- | Converts a line of cells to a line of pictures by calling 
-- renderCell for each cell in the line
cellsToPictures :: Line Cell -> Line Picture
cellsToPictures (Line xs y zs) = Line left (renderCell y) right
  where
    left = map renderCell xs
    right = map renderCell zs

-- | Render the fist N steps of Rule 30,
-- applied to a given starting line.
-- Note: width of each line is equal to n*2+1 
-- Note: adds an infinite number of Dead cells to left and right lists 
--       to be able to evaluate further cells
renderRule30 :: Int -> Line Cell -> Picture
renderRule30 n line = helper n n line
  where
    helper _ 0 _ = blank
    helper lineSize step (Line xs y zs) = cur <> next
      where
        cur = renderLine (cellsToPictures (cutLine (lineSize) 
          (Line (xs ++ (repeat Dead)) y (zs ++ (repeat Dead)))))
        next = translated 0 (-1) (helper lineSize (step-1) (applyRule30 
          (Line (xs ++ (repeat Dead)) y (zs ++ (repeat Dead)))))

--------------------------------------------------------------------------------
-- Discrete Space
-- A discrete 2D space can be represented by a (vertical) lines
-- of (horizontal) lines

-- | A descrete 2D space with a focus.
-- A 2D space is merely a (vertical) line
-- where each element is a (horizontal) line.
data Space a = Space (Line (Line a)) 
  deriving ( Show) 

-- Exercise 1.9 
-- | Concatenates an argument with all parts of a line 
-- returns a line of tuples with the first argument as the first 
-- part in the tuple and the line elements as the second part
productOfElementByLine :: a -> Line b -> Line (a,b)
productOfElementByLine x (Line a b c ) = (Line (map (\y -> (x,y)) a) 
                                               (x,b) 
                                               (map (\y -> (x,y)) c))

-- | Concatenates a list of arguments with all parts of a line
-- by using productOfElementByLine with each argument with the line
-- returns a list of line of tuples
productOfListByLine :: [a] -> Line b -> [Line (a,b)]
productOfListByLine xs b = map (\x -> productOfElementByLine x b) xs

-- | Produces a cartesian product of two lines 
-- returns a space of tuples which is a line of lines of tuples
productOfLines :: Line a -> Line b -> Space (a, b)
productOfLines (Line a b c) x = Space (Line (productOfListByLine a x) 
                                            (productOfElementByLine b x) 
                                            (productOfListByLine c x) )
-- >>> productOfLines (Line [1] 2 [3]) (Line [4] 5 [6])
-- Space (Line [Line [(1,4)] (1,5) [(1,6)]] 
--       (Line [(2,4)] (2,5) [(2,6)]) 
--       [Line [(3,4)] (3,5) [(3,6)]])

-- Exercise 1.10
-- | Apply a function on all elements of a space
mapSpace :: (a -> b) -> Space a -> Space b
mapSpace f (Space line) = (Space (mapLine (mapLine f) line))
-- >>> mapSpace (*2) (Space (Line [(Line [1] 2 [3])] 
--                                (Line [4] 5 [6]) 
--                                [(Line [7] 8 [9])]))
-- Space (Line [Line [2] 4 [6]] (Line [8] 10 [12]) [Line [14] 16 [18]])

-- | Zip togther two spaces
zipSpaces :: Space a -> Space b -> Space (a, b)
zipSpaces (Space line1) (Space line2) = 
  (Space (zipLinesWith zipLines line1 line2))
-- >>> zipSpaces (Space (Line [(Line [1] 2 [3])] 
--                            (Line [4] 5 [6]) 
--                            [(Line [7] 8 [9])])) 
--               (Space (Line [Line [2] 4 [6]] 
--                            (Line [8] 10 [12]) 
--                            [Line [14] 16 [18]]))
-- Space (Line [Line [(1,2)] (2,4) [(3,6)]] 
--             (Line [(4,8)] (5,10) [(6,12)]) 
--             [Line [(7,14)] (8,16) [(9,18)]])

-- | Zip togther two spaces with a given combining function
zipSpacesWith :: (a -> b -> c) -> Space a -> Space b -> Space c
zipSpacesWith f (Space line1) (Space line2) = 
  (Space (zipLinesWith (zipLinesWith f) line1 line2))
-- >>> zipSpacesWith (+) (Space (Line [(Line [1] 2 [3])] 
--                              (Line [4] 5 [6]) 
--                              [(Line [7] 8 [9])])) 
--                       (Space (Line [Line [2] 4 [6]] 
--                              (Line [8] 10 [12]) 
--                              [Line [14] 16 [18]]))
-- Space (Line [Line [3] 6 [9]] (Line [12] 15 [18]) [Line [21] 24 [27]])

-- Exercise 1.11 "This is accidental duplication, you may ignore exercise 1.11."

--------------------------------------------------------------------------------
-- Conway's Game of Life
-- implement Conway’s Game of Life by using our definition of discrete space.

-- Exercise 1.12
-- | Returns the first line of a list of lines
-- if list is empty returns a line of of only dead focus
firstLine :: [Line Cell] -> Line Cell
firstLine [] = Line [] Dead []
firstLine (line:_) = line

-- | Returns the number of alive cells 
-- from a list of cells
countAlive :: [Cell] -> Int
countAlive [] = 0
countAlive(Dead: cells) = countAlive cells
countAlive (Alive: cells) = 1 + countAlive cells

-- | Applies conway's rule to a space of cells 
-- returns the new state of the focus cell
conwayRule :: Space Cell -> Cell
conwayRule (Space (Line below (Line l m r) above)) = result
    where
        aliveInLine (Line left mid right) = 
          countAlive [checkList left, mid, checkList right]
        aliveBelow = aliveInLine (firstLine below)
        aliveTop = aliveInLine (firstLine above)

        totalNeighbors = aliveBelow + aliveTop 
                         + countAlive [checkList l, checkList r]
        result
            | totalNeighbors == 3 = Alive
            | totalNeighbors == 2 && cellToBool m = Alive
            | otherwise = Dead
  
-- Exercise 1.13
-- | Removes all maybes(Just, Nothing) from a list of (Maybe a)
-- if element is Nothing doesn't add anything to the returned list
-- if element is Just x adds x to the returned list
cleanMaybeList :: [Maybe a] -> [a]
cleanMaybeList [] = []
cleanMaybeList (Nothing:xs) = cleanMaybeList xs
cleanMaybeList (Just x:xs)  = x : cleanMaybeList xs

-- | Parses a line of (Maybe a) to Maybe (Line a)
-- if a is Nothing returns Nothing
-- otherwise returns Just Line a after removing all maybes from left 
-- and right lists of the line 
parseLineMaybeToMaybeLine :: (Line (Maybe a)) -> Maybe (Line a) 
parseLineMaybeToMaybeLine (Line _ Nothing _)    = Nothing
parseLineMaybeToMaybeLine (Line left (Just mid) right) = 
  Just ( Line (cleanMaybeList left) mid (cleanMaybeList right))

-- | Produces a space of spaces by first generating a 
-- line of spaces then generating a line of line of spaces
-- by first shifting the foci to get the line of spaces 
-- then shifting once again on the returned line of spaces 
-- to get a space of spaces with all foci
spaceShifts :: Space a -> Space (Space a)
spaceShifts (Space linees) = 
  mapSpace Space (Space ( genSpace (genSpace linees))) 
  where
    genSpace line = genLine (parseLineMaybeToMaybeLine . mapLine shiftLeft) 
                            line 
                            (parseLineMaybeToMaybeLine . mapLine shiftRight)

-- | Applies conwayRule to every cell in a space of cells 
-- gets all spaces with different foci with spaceShifts
-- returns a space of cells with the new cells by applying 
-- rule30 on each space
applyConwayRule :: Space Cell -> Space Cell
applyConwayRule space = mapSpace conwayRule (spaceShifts space)

-- Exercise 1.14
-- | Renders a list of line pictures in a single picture
-- given an operator to define the translation shift for each line picture
renderLines :: [Line Picture] -> (Double -> Double) -> Picture
renderLines [] _ = blank
renderLines (x:xs) op = renderLine x <> 
                        (translated 0 (op 1) (renderLines xs op))

-- | Render a space of 1x1 pictures.
-- by rendering the focus line, and applying renderLines to 
-- left list and right list of lines with (*(-1)) and (*1) operators
-- to specify translation shift
renderSpace :: Space Picture -> Picture
renderSpace (Space (Line xs y zs)) =  
  (translated 0 1 (renderLines xs (*1)))
  <> (renderLine y) 
  <> (translated 0 (-1) (renderLines zs (*(-1)))) 

-- | Animate Conway's Game of Life,
-- starting with a given space
-- and updating it every second.
animateConway :: Space Cell -> IO ()
animateConway initial = activityOf (initial, 0) handler 
                                   (renderSpace . mapSpace renderCell . fst)
  where
    handler (TimePassing dt) (cells, t)
      | t > 1     = (applyConwayRule cells, 0)
      | otherwise = (cells, t + dt)
    handler _ s = s


--------------------------------------------------------------------------------

-- Please note that this example was completely copied from a last year student
-- solely for testing porpuses. 
main :: IO ()
main = animateConway pulsar
  where
    block = Space (Line
      [ Line [Dead] Alive [Alive, Dead]
      , Line [Dead] Dead  [Dead,  Dead]]
      ( Line [Dead] Alive [Alive, Dead])
      [ Line [Dead] Dead  [Dead,  Dead]]
      )
    blinker = Space (Line
      [ Line [Dead] Alive [Dead] ]
      (Line [Dead] Alive [Dead])
      [ Line [Dead] Alive [Dead] ])
    pulsar = Space (Line
      pulsarHalf
      (Line (replicate 7 Dead) Dead (replicate 7 Dead))
      pulsarHalf
      )
      where
        pulsarHalf =
          [ Line [Dead, Alive, Alive, Alive, Dead, Dead, Dead] Dead [Dead, Alive, Alive, Alive, Dead, Dead, Dead]
          , Line [Alive, Dead, Dead, Dead, Dead, Alive, Dead] Dead [Alive, Dead, Dead, Dead, Dead, Alive, Dead]
          , Line [Alive, Dead, Dead, Dead, Dead, Alive, Dead] Dead [Alive, Dead, Dead, Dead, Dead, Alive, Dead]
          , Line [Alive, Dead, Dead, Dead, Dead, Alive, Dead] Dead [Alive, Dead, Dead, Dead, Dead, Alive, Dead]
          , Line (replicate 7 Dead) Dead (replicate 7 Dead)
          , Line [Dead, Alive, Alive, Alive, Dead, Dead, Dead] Dead [Dead, Alive, Alive, Alive, Dead, Dead, Dead]
          , Line (replicate 7 Dead) Dead (replicate 7 Dead)
          ]