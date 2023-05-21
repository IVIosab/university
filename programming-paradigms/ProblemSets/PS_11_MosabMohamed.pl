member(X, [X|_]).
member(X, [_|T]) :- member(X, T).

% Exercise 1.a
subseq([],_).
subseq([X|XS], [X|YS]) :- subseq(XS, YS).
subseq([X|XS], [_|YS]) :- subseq([X|XS], YS).

% Exercise 1.b
sublist([], X, X).
sublist([H|T],[H|L], X) :- sublist(T, L, X).

search(X,Y,0) :- sublist(X,Y,_).
search(X,[_|YS],P) :- search(X,YS,NP), P is NP+1.

% Exercise 1.c
replace(_, _, [], []).
replace(O, N, [X|OW], [X|NW]) :- replace(O, N, OW, NW).
replace(O, N, OW, NW) :- sublist(O, OW, R1), sublist(N, NW, R2), replace(O, N, R1, R2).

% Exercise 1.d
suffix(X,X).
suffix(X,[_|YS]) :- suffix(X,YS).

% Exercise 1.e
repeat(_,[]).
repeat(X, [X|XS]) :- repeat(X,XS).

% Exercise 2.a
allLEQ(_,[]).
allLEQ(X,[Y|YS]):- (X =< Y), allLEQ(X,YS).

allGEQ(_,[]).
allGEQ(X,[Y|Ys]):- (X >= Y), allGEQ(X,Ys).

% Exercise 2.b
minimum(X,Y) :- member(X,Y), allLEQ(X,Y).

% Exercise 2.c 
partition(_, [], [], []).
partition(P, [P|T], L1, L2):- partition(P, T, L1, L2).
partition(P, [H|T], L1, [H|T2]) :- H > P, partition(P, T, L1, T2).
partition(P, [H|T], [H|T1], L2) :- H < P, partition(P, T, T1, L2).

% Exercise 2.d
median(X,Y) :- member(X,Y), partition(X,Y,L,G), length(L, N), length(G, N).

% Exercise 3.a 
ones([]).
ones([1|X]) :- ones(X).

zeroes([]).
zeroes([0|X]) :- zeroes(X).

getSize([],[],0).
getSize([_|XS],[_|YS], N) :- getSize(XS,YS, NN), N is (NN + 1).

increment(X,[1|Y]) :-  getSize(X,Y,M), length(X,M), length(Y,M), zeroes(Y), ones(X).
increment([0|X],[1|Y]) :- getSize(X,Y,M),  length(X,M), length(Y,M), zeroes(Y), ones(X).
increment([X|XS], [X|YS]) :- getSize(XS,YS,M), length(XS,M), length(YS,M), increment(XS,YS).

% Exercise 3.b
notZeroes(X) :- zeroes(X), ! , fail.
notZeroes(_).

countTrailingZeros(X, N) :- zeroes(X), length(X,M), N is M.
countTrailingZeros([X|Xs],N) :- notZeroes([X|Xs]), countTrailingZeros(Xs, N).

% Exercise 4
fib2(0,1).
fib2(X,Y) :- fib2(Z, X), Y is (Z + X).

fib(0).
fib(X) :- fib2(_,X).
