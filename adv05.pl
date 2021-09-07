door_id(reyedfim).

find_index(0, _, []) :- !.
find_index(N, K, [X|Xs]) :-
    N > 0, N1 is N - 1,
    door_id(D), atom_chars(D, DL),
    number_chars(K, KL),
    append(DL, KL, CL),
    atom_chars(C, CL),
    md5_hash(C, M, []),
    atom_chars(M, L),
    prefix(['0','0','0','0','0',X], L), !,
    K1 is K + 1,
    find_index(N1, K1, Xs).
find_index(N, K, Xs) :- K1 is K + 1, find_index(N, K1, Xs).

% ~ 15s
adv05(X) :- find_index(8, 0, L), atom_chars(X, L).

find_index(N, L) :- find_index(N, 0, [], L).
find_index(0, _, A, A) :- !.
find_index(N, K, A, Xs) :-
    N > 0, N1 is N - 1,
    door_id(D), atom_chars(D, DL),
    number_chars(K, KL),
    append(DL, KL, CL),
    atom_chars(C, CL),
    md5_hash(C, M, []),
    atom_chars(M, L),
    prefix(['0','0','0','0','0',X,Y], L),
    atom_number(X, XN), XN < 8,
    \+ member(XN-_, A), !,
    write('.'), flush_output, % show progress
    K1 is K + 1,
    find_index(N1, K1, [XN-Y|A], Xs).
find_index(N, K, A, Xs) :- K1 is K + 1, find_index(N, K1, A, Xs).

% ~ 50s
adv05b(X) :-
    find_index(8, L),
    keysort(L, L1),
    pairs_values(L1, L2),
    atom_chars(X, L2).
