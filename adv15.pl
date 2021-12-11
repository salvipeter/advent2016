% Part 1
% discs([13-1,19-10,3-2,7-1,5-3,17-5]).

% Part 2
discs([13-1,19-10,3-2,7-1,5-3,17-5,11-0]).

normalize(Ds, Ds1) :- normalize(Ds, 1, Ds1).
normalize([], _, []).
normalize([D-K|Ds], N, [D-K1|Ds1]) :-
    K1 is (K + N) mod D, N1 is N + 1,
    normalize(Ds, N1, Ds1).

falls(N, D-K) :- (K + N) mod D =:= 0.

maximum([D-_], D).
maximum([D-_|Ds], X) :- maximum(Ds, X0), X is X0 * D.

find(Ds, N) :-
    maximum(Ds, Max),
    between(1, Max, N),
    maplist(falls(N), Ds).

adv15(X) :- discs(Ds0), normalize(Ds0, Ds), find(Ds, X).
