% Exercise 1.a
minimum([X], X).
minimum([X,Y|R], Z) :- Y < X, minimum([Y|R], Z).
minimum([X,Y|R], Z) :- X =< Y, minimum([X|R], Z).

% Exercise 1.b
unifies(_, []).
unifies(X, [Y|R]) :- \+ \+ X = Y, unifies(X, R). 

leastSpecific(T, L) :- member(T, L), unifies(T, L).

% Exercise 2.a
remove(_, [], []) :- !.
remove(X, [X|A], B) :- !, remove(X, A, B).
remove(X, [Y|A], [Y|B]) :- remove(X, A, B).

% Exercise 2.b
removeU(_X, [], []) :- !.
removeU(X, [Y|A], B) :- \+ \+ X = Y, !, removeU(X, A, B).
removeU(X, [Y|A], [Y|B]) :- removeU(X, A, B).

% Exercise 3.a
nat(0).
nat(N) :- nat(K), N is K+1.

nat(0, 0) :- !.
nat(0, Max) :- Max > 0.
nat(N, Max) :- M is Max-1, nat(K, M), N is K+1.

neg(Goal) :- Goal, !, fail.
neg(_Goal).

factor(N, Y) :- nat(X, Y), X > 1, 0 is N mod X, !.

prime(N) :- nat(N), N > 1, succ(Y, N), neg(factor(N, Y)).

% Exercise 3.b
commonFactor(Y1, Y2, N, M) :- nat(X1, Y1), X1 >= 1, nat(X2, Y2), X2 >= 1, X1 * M =:= X2 * N, !.

coprime(N, M) :- nat(N), N > 1, nat(M), M > 1, succ(Y1, N), succ(Y2, M), neg(commonFactor(Y1, Y2, N, M)).


