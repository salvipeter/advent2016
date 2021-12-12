state([1,1,1,0,1,0,0,0,1,1,0,0,1,0,1,0,0]).

take(0, _, []).
take(N, [X|Xs], [X|Ys]) :- N > 0, N1 is N - 1, take(N1, Xs, Ys).

grow(X, Y) :- grow(X, [], Y0), append(X, Y0, Y).
grow([], A, [0|A]).
grow([0|X], A, Y) :- grow(X, [1|A], Y).
grow([1|X], A, Y) :- grow(X, [0|A], Y).

grow_until(N, X, Y) :- length(X, L), L >= N, take(N, X, Y).
grow_until(N, X, Y) :- grow(X, Z), grow_until(N, Z, Y).

checksum(L, X) :- length(L, N), N mod 2 =:= 1, !, atomic_list_concat(L, X).
checksum(L, X) :- checksum_once(L, C), checksum(C, X).

checksum_once([], []).
checksum_once([D,D|L], [1|X]) :- !, checksum_once(L, X).
checksum_once([_,_|L], [0|X]) :- checksum_once(L, X).

adv16(X) :- state(S), grow_until(272, S, S1), checksum(S1, X).

adv16b(X) :- state(S), grow_until(35651584, S, S1), checksum(S1, X).
