% student(Name, Group)
student(alisa, 2).
student(bob, 1).
student(chloe, 2).
student(denise, 1).
student(edward, 2).

% friend(Name, Name)
friend(alisa, bob).
friend(alisa, denise).
friend(bob, chloe).
friend(bob, edward).
friend(chloe, denise).
friend(denise, edward).

% parent(Parent, Child)
parent(marjorie, bart).
parent(marjorie, lisa).
parent(marjorie, maggie).
parent(homer, bart).
parent(homer, lisa).
parent(homer, maggie).
parent(abraham, homer).
parent(mona, homer).
parent(jacqueline, marjorie).
parent(jacqueline, patty).
parent(jacqueline, selma).
parent(clancy, marjorie).
parent(clancy, patty).
parent(clancy, selma).
parent(selma, ling).

% Exercise 2
groupmates(X,Y) :- student(X,Z), student(Y,Z).

% Exercise 3 
ancestor(X, Y) :- parent(X,Y).
ancestor(X, Y) :- parent(X,Z), ancestor(Z,Y).

relative(X, Y) :- ancestor(Z,X), ancestor(Z,Y).

% Exercise 4.a
unary(z).
unary(s(N)) :- unary(N).

add(z, Y, Y).
add(s(X), Y, s(R)) :- add(X, Y, R).

double(X,Y) :- add(X,X,Y).

% Exercise 4.b
leq(X,Y) :- add(X, _Z, Y).

% Exercise 4.c
mult(z,_,z).
mult(s(X), Y, Z) :- add(Y,R,Z), mult(X,Y,R).

% Exercise 4.d
powerOf2(z,s(z)).
powerOf2(s(N), M) :-   add(X, X, M), leq(N, M), powerOf2(N, X).