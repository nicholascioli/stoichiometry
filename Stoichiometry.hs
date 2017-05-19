import Data.Char
import qualified Data.Set as S
import System.Environment

-- Define a keyword used to make failed edges
fail_keyword :: String
fail_keyword = "\0"

-- A list of elements to search through. 
-- Note: Elements with 3 characters are not searched
elements :: S.Set String
elements = S.fromList [
		"Ac", "Ag", "Al", "Am", "Ar", "As", "At", "Au", "B", "Ba", "Be", "Bh", "Bi", 
		"Bk", "Br", "C", "Ca", "Cd", "Ce", "Cf", "Cl", "Cm", "Cn", "Co", "Cr", "Cs", "Cu", "Db", 
		"Ds", "Dy", "Er", "Es", "Eu", "F", "Fe", "Fl", "Fm", "Fr", "Ga", "Gd", "Ge", "H", "He", 
		"Hf", "Hg", "Ho","Hs", "I", "In", "Ir", "K", "Kr", "La", "Li", "Lr", "Lu", "Lv", "Md", 
		"Mg", "Mn", "Mo", "Mt", "N", "Na", "Nb", "Nd", "Ne", "Ni", "No", "Np", "O", "Os", "P", 
		"Pa", "Pb", "Pd", "Pm", "Po", "Pr", "Pt", "Pu", "Ra", "Rb", "Re", "Rf", "Rg", "Rh", "Rn", 
		"Ru", "S", "Sb", "Sc", "Se", "Sg", "Si", "Sm", "Sn", "Sr", "Ta", "Tb", "Tc", "Te", "Th", 
		"Ti", "Tl", "Tm", "U", "V", "W", "Xe", "Y", "Yb", "Zn", "Zr"
	]

-- Define a basic binary tree. Deriving show for displaying the inner elements
data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Eq, Show)

-- Traversal Method
-- The basics of the algorithm are as follows:
-- * Create a root node with the full string
-- * Start the recursive stack on each child
--   * Left child gets top two characters, if they are an element (if possible)
--   * Right child gets top character, if it is an element (if possible)
trav_ :: String -> Tree String
trav_ str = Node (doTrav_ str True) str (doTrav_ str False)

-- TODO: Make this an inner method of trav_
doTrav_ :: String -> Bool -> Tree String
doTrav_ str two
	| (two == True  && len_s > 1 && S.member [toUpper (str !! 0), str !! 1] elements)
		= addNode [toUpper (str !! 0), str !! 1] (tail $ tail str)
	| (two == False && len_s > 0 && S.member [toUpper $ head str] elements) 
		= addNode [toUpper $ head str] (tail str)
	| otherwise
		= Leaf fail_keyword
	where len_s = length str

-- TODO: Make this an inner method of doTrav_
addNode :: String -> String -> Tree String
addNode c o 
	| (length o == 0) = Leaf c
	| otherwise = Node (doTrav_ o True) c (doTrav_ o False)

-- Prints the elemental version of the input word
-- Works by generating an empty list of strings and adding each possible path result
-- to the list.
toElement :: Tree String -> [String]
toElement (Node l c r) = (doToElement l "") ++ (doToElement r "")

-- TODO: Make this an inner method of toElement
doToElement :: Tree String -> String -> [String]
doToElement (Leaf a) ws
	| (a == fail_keyword) = []
	| otherwise = [ws ++ a]
doToElement (Node l c r) ws = (doToElement l (ws ++ c)) ++ (doToElement r (ws ++ c))

-- Prints all of the results from a string list
printRes :: [String] -> IO ()
printRes ss
	| (length ss > 0) = putStr $ unlines ss
	| otherwise = return ()


-- Given a word from user input, attempt to create an elemental spelling of the word
main :: IO ()
main = do
	a <- getArgs
	if length a > 0
		then printRes $ toElement (trav_ $ a !! 0)
		else putStrLn "Error: Need a word to convert"