%Exercise 1.1
%tree/1
%Predicate that checks whether a given term is a valid tree.
% It takes each node and calls left and right subtrees in a recursive call.
% It gives True if the term is equal to 'empty'.
tree(empty).
tree(node(_, Left, Right)):- tree(Left), tree(Right).


%Exercise 1.2
%containedTree/2, containedTree(Tree1, Tree2)
%Predicate that checks if the first tree is contained in the second one
% It calls the first left subtree with the second left subtree and the same for the right part
% with a recursive call to check if the first one contained in the second one.
% It gives True when the first tree is empty because empty is contained in all trees.
containedTree(empty, empty).
containedTree(empty, node(_,_,_)).
containedTree(node(Root,Left1,Right1), node(Root,Left2,Right2)):- 
    containedTree(Left1, Left2), containedTree(Right1, Right2).


%Exercise 1.3
%from/2, from(Start, List)
%Predicate that checks if the list consists of consecutive numbers starting from Start
% If Start is equal to the first element in the list 
% It initializes Next as (Start + 1) then call from with Next and the list excluding the first elemnt
% It gives True when the list is empty
from(_, []).
from(Start, [Start|Rest]):- Next is (Start+1), from(Next, Rest).


%Exercise 1.4
%preorder/2 preorder(Tree, List)
%Predicate that checks if the list is comprised of the values from the tree in preorder traversal
% It checks if the left subtree list concatenated with the right subtree list will result in
% the current list
% for that it calls 2 recursive calls, one with the left subtree and its list 
% the other for the right subtree and its list 
% then it compares the left and right lists and the current value with the current list 
preorder(empty, []).
preorder(node(Value,Left,Right), List):- append([Value|LeftList], RightList, List), 
    preorder(Left, LeftList), preorder(Right, RightList).


%Exercise 1.5
%less/2
%Predicate to check if the first term is less than the second term 
% It also accounts for infinite values
less(-infinity, _):- !.
less(_, +infinity):- !.
less(X, Y):- (X < Y).

%leq/2
%Predicate to check if the first term is less than or equal the second term 
% It also accounts for infinite values
leq(-infinity, _):- !.
leq(_, +infinity):- !.
leq(X, Y):- (X =< Y).


%Utilities
%great/2
%Predicate to check if the first term is greater than the second term 
% It also accounts for infinite values
great(_, -infinity):- !.
great(+infinity, _):- !.
great(X, Y):- (X > Y).

%geq/2
%Predicate to check if the first term is greater than or equal the second term 
% It also accounts for infinite values
geq(_, -infinity):- !.
geq(+infinity, _):- !.
geq(X, Y):- (X >= Y).

%greatAll/2
%Predicate to check if the first term is greater than all the values in the list 
greatAll(_, []).
greatAll(Value, [First|Rest]):- great(Value, First), greatAll(Value, Rest).

%lessAll/2
%Predicate to check if the first term is less than all the values in the list 
lessAll(_, []).
lessAll(Value, [First|Rest]):- less(Value, First), lessAll(Value, Rest). 

%geqAll/2
%Predicate to check if the first term is greater than or equal all the values in the list 
geqAll(_, []).
geqAll(Value, [First|Rest]):- geq(Value, First), geqAll(Value, Rest).

%leqAll/2
%Predicate to check if the first term is less than or equal all the values in the list 
leqAll(_, []).
leqAll(Value, [First|Rest]):- leq(Value, First), leqAll(Value, Rest). 


%Exercise 1.6
%bst/1
%Predicate that checks if the given is a valid binary search tree or not
% by checking for each subtree if its value is less than all the nodes on the left 
% and greater than all the nodes on the right
bst(empty).
bst(node(Value,Left,Right)):- 
    preorder(Left, LeftList), !, greatAll(Value, LeftList), 
    preorder(Right, RightList), !, lessAll(Value, RightList), 
    bst(Left), bst(Right).


%Exercise 1.7
%bstInsert/3 bstInsert(Value, Before, After)
%Predicate that checks if After is a BST produced from inserting Value into Before
% by finding its correct place by checking the values of each subtree
bstInsert(Value, empty, node(Value,empty,empty) ).
bstInsert(Value, node(X,Left1,Right), node(X, Left2, Right) ) :- 
    Value < X, !, bstInsert(Value, Left1, Left2).
bstInsert(Value, node(X, Left, Right1), node(X, Left, Right2) ) :-
    Value > X, bstInsert(Value, Right1, Right2).


%Exercise 1.8
%bstMin/2 bstMin(Tree, Min) 
%Predicate that checks if Min is the minimum value in the BST given in Tree
% by checking if Min is equal to the leftmost leaf in the tree
bstMin(node(Value,empty,_), Value).
bstMin(node(_,Left,_), Value):- bstMin(Left, Value).

%bstMax/2 bstMax(Tree, Max)
%Predicate that checks if Max is the maximum value in the BST given in Tree
% by checking if Max is equal to the rightmost leaf in the tree
bstMax(node(Value,_,empty), Value).
bstMax(node(_,_,Right), Value):- bstMax(Right, Value).


%Exercise 1.9
%TODO


%Exercise 2.1
%expr/1
%Predicat that checks if the given is a valid arithmetic expression based on the following rules:
% Variables are not allowed 
% only + and * are allowed
expr(X):- var(X), !, fail.
expr(X*Y):- expr(X), expr(Y).
expr(X+Y):- expr(X), expr(Y).
expr(X):- number(X).


%Exercise 2.2
%expr/2 expr(Expr, Values)
%Predicate that checks if the first expression is comprised of the values from the list 
% where it uses each value once and in order
expr(X, [X]).
expr(X+Expr, [X|Rest]):- expr(X), expr(Expr, Rest).
expr(X*Expr, [X|Rest]):- expr(X), expr(Expr, Rest).


%Exercise 2.3
%equation/2 equation(Values, Result=Expr)
%Predicate that checks if Expr uses each element from Values once and in order, 
% and Result is a correct result of the arthimetic expression
equation(List, Equation) :- expr(Expr, List), Ans is Expr, Equation = (Ans = Expr).


%Exercise 2.4
%equations/2 equations(Values, Equations)
%Predicate that checks if Equations is a list of all distinct equations 
% that can be produced from Values
% Reference: https://stackoverflow.com/questions/4191038/getting-list-of-solutions-in-prolog
equations(List, Eqs, Equations) :-
    equation(List, NewEq),
    \+ member(NewEq, Eqs), !,
    equations(List, [NewEq|Eqs],Equations).
equations(_, Equations, Equations).

equations(List, Equations) :-
    equations(List,[],Equations).