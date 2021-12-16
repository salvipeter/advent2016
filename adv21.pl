swap(_, _, [], []).
swap(X, Y, [X|L], [Y|L1]) :- !, swap(X, Y, L, L1).
swap(X, Y, [Y|L], [X|L1]) :- !, swap(X, Y, L, L1).
swap(X, Y, [A|L], [A|L1]) :- X \= A, Y \= A, swap(X, Y, L, L1).

rotate_left(N, L, A, L1) :-
    length(L, K), N >= K, !,
    N1 is N mod K,
    rotate_left(N1, L, A, L1).
rotate_left(0, L, A, L1) :- reverse(A, A1), append(L, A1, L1), !.
rotate_left(N, [X|Xs], A, L1) :-
    N > 0, N1 is N - 1,
    rotate_left(N1, Xs, [X|A], L1).

reverse_part(_, -1, L, A, L1) :- !, append(A, L, L1).
reverse_part(X, Y, [Z|L], A, L1) :-
    X =< 0, !, Y >= 0,
    X1 is X - 1, Y1 is Y - 1,
    reverse_part(X1, Y1, L, [Z|A], L1).
reverse_part(X, Y, [Z|L], A, [Z|L1]) :-
    X > 0,
    X1 is X - 1, Y1 is Y - 1,
    reverse_part(X1, Y1, L, A, L1).

insert(0, X, L, [X|L]) :- !.
insert(N, X, [Y|L], [Y|L1]) :- N > 0, N1 is N - 1, insert(N1, X, L, L1).

scramble(swap(X,Y), L, L1) :-
    number(X), !,
    nth0(X, L, CX), nth0(Y, L, CY),
    scramble(swap(CX,CY), L, L1).
scramble(swap(X,Y), L, L1) :- swap(X, Y, L, L1).
scramble(left(N), L, L1) :- rotate_left(N, L, [], L1).
scramble(right(N), L, L1) :- length(L, K), N1 is (K - N) mod K, rotate_left(N1, L, [], L1).
scramble(rotate(C), L, L1) :-
    nth0(N, L, C),
    ( N >= 4 -> N1 is N + 2 ; N1 is N + 1 ),
    scramble(right(N1), L, L1).
scramble(reverse(X,Y), L, L1) :- reverse_part(X, Y, L, [], L1).
scramble(move(X,Y), L, L1) :-
    nth0(X, L, CX),
    select(CX, L, L0),
    insert(Y, CX, L0, L1).

scramble_all([], L, L).
scramble_all([S|Ss], L, L1) :- scramble(S, L, L0), scramble_all(Ss, L0, L1).

adv21(X) :-
    scrambling(S),
    scramble_all(S, [a,b,c,d,e,f,g,h], L),
    atomic_list_concat(L, X), !.

% - swap and reverse are the same
% - left, right and move only need to swap the direction
% - the only problem is rotate, so let's try all rotations
unscramble(swap(X,Y), L, L1) :-
    number(X), !,
    nth0(X, L, CX), nth0(Y, L, CY),
    unscramble(swap(CX,CY), L, L1).
unscramble(swap(X,Y), L, L1) :- swap(X, Y, L, L1).
unscramble(left(N), L, L1) :- length(L, K), N1 is (K - N) mod K, rotate_left(N1, L, [], L1).
unscramble(right(N), L, L1) :- rotate_left(N, L, [], L1).
unscramble(rotate(C), L, L1) :-
    length(L, K), K1 is K - 1,
    between(0, K1, R), % try all variations
    unscramble(right(R), L, L1),
    nth0(N, L1, C),
    ( N >= 4 -> R =:= (N + 2) mod K ; R =:= (N + 1) mod K ).
unscramble(reverse(X,Y), L, L1) :- reverse_part(X, Y, L, [], L1).
unscramble(move(X,Y), L, L1) :-
    nth0(Y, L, CY),
    select(CY, L, L0),
    insert(X, CY, L0, L1).

unscramble_all([], L, L).
unscramble_all([S|Ss], L, L1) :- unscramble(S, L, L0), unscramble_all(Ss, L0, L1).

adv21b(X) :-
    scrambling(S), reverse(S, R),
    unscramble_all(R, [f,b,g,d,c,e,a,h], L),
    atomic_list_concat(L, X), !.

scrambling([right(3),swap(7,0),left(3),reverse(2,5),move(6,3),reverse(0,4),swap(4,2),rotate(d),right(0),move(7,5),swap(4,5),swap(3,5),move(5,3),swap(e,f),swap(6,3),swap(a,e),reverse(0,1),reverse(0,4),swap(c,e),reverse(1,7),right(1),reverse(6,7),move(7,1),move(4,0),move(4,6),move(6,3),swap(1,6),swap(5,7),swap(2,5),swap(6,5),swap(2,4),reverse(2,6),reverse(3,5),move(3,5),reverse(1,5),left(1),move(4,5),swap(c,b),swap(2,1),reverse(3,4),swap(3,4),reverse(5,7),swap(b,d),reverse(3,4),swap(c,h),rotate(b),rotate(e),right(3),right(7),left(2),move(6,1),reverse(1,3),rotate(b),reverse(0,4),swap(g,c),move(1,5),right(4),left(2),move(7,2),rotate(c),move(6,1),swap(f,g),right(6),swap(6,2),reverse(2,6),swap(3,1),rotate(h),reverse(2,5),move(1,3),right(1),right(7),move(6,3),rotate(h),swap(d,h),left(0),move(1,2),swap(a,g),swap(a,g),swap(4,2),right(1),rotate(b),swap(7,1),rotate(e),move(1,4),move(6,3),left(3),swap(f,g),swap(3,1),swap(4,3),swap(f,c),left(3),left(0),right(3),swap(d,e),swap(2,7),move(3,6),swap(7,1),swap(3,6),left(5),swap(2,6)]).
