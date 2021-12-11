salt(qzyelonm).

% Part 1
% md5(D, H) :- md5_hash(D, H, []).

% Part 2
md5(D, H) :- md5(D, 2017, H).
md5(D, 0, D).
md5(D, N, H) :-
    N > 0, N1 is N - 1,
    md5_hash(D, H0, []),
    md5(H0, N1, H).

:- table(hash/2).
hash(N, L) :-
    salt(S), atomic_concat(S, N, D),
    md5(D, H),
    atom_chars(H, L).

check(L, N, D) :- check(L, N, N, D).
check([X,X|_], _, 2, X) :- !.
check([X,X|Xs], N, K, D) :- K > 1, K1 is K - 1, check([X|Xs], N, K1, D).
check([X,Y|Xs], N, _, D) :- X \= Y, check([Y|Xs], N, N, D).

find(K, K) :-
    hash(K, L), check(L, 3, D),
    I1 is K + 1, I2 is K + 1000,
    between(I1, I2, I),
    hash(I, L1), check(L1, 5, D).
find(K, N) :- K1 is K + 1, find(K1, N).

find_nth(0, K, K).
find_nth(N, K, X) :-
    N > 0, N1 is N - 1,
    K1 is K + 1,
    find(K1, K2),
    find_nth(N1, K2, X).

adv14(X) :- find_nth(64, 0, X), !.
