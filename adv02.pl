part(1). % change to part(2)

next(1, r, 2). next(1, d, 4).
next(2, l, 1). next(2, r, 3). next(2, d, 5).
next(3, l, 2). next(3, d, 6).
next(4, u, 1). next(4, r, 5). next(4, d, 7).
next(5, u, 2). next(5, l, 4). next(5, r, 6). next(5, d, 8).
next(6, u, 3). next(6, l, 5). next(6, d, 9).
next(7, u, 4). next(7, r, 8).
next(8, u, 5). next(8, l, 7). next(8, r, 9).
next(9, u, 6). next(9, l, 8).
next(X, _, X).

compute_codes([], _, _, []).
compute_codes([[]|Ys], K, K1, [K|R]) :-
    compute_codes(Ys, K, K1, R).
compute_codes([[X|Xs]|Ys], K, K2, R) :-
    ( part(1), next(K, X, K1) ; next1(K, X, K1) ), !,
    compute_codes([Xs|Ys], K1, K2, R).

adv02(X) :- codes(C), compute_codes(C, 5, _, X).

next1(1, d, 3).
next1(2, r, 3). next1(2, d, 6).
next1(3, u, 1). next1(3, l, 2). next1(3, r, 4). next1(3, d, 7).
next1(4, l, 3). next1(4, d, 8).
next1(5, r, 6).
next1(6, u, 2). next1(6, l, 5). next1(6, r, 7). next1(6, d, a).
next1(7, u, 3). next1(7, l, 6). next1(7, r, 8). next1(7, d, b).
next1(8, u, 4). next1(8, l, 7). next1(8, r, 9). next1(8, d, c).
next1(9, l, 8).
next1(a, u, 6). next1(a, r, b).
next1(b, u, 7). next1(b, l, a). next1(b, r, c). next1(b, d, d).
next1(c, u, 8). next1(c, l, b).
next1(d, u, b).
next1(X, _, X).

codes([[l,l,l,r,l,l,u,l,l,d,d,l,d,u,d,r,d,d,u,r,l,d,d,r,d,l,r,d,d,r,u,u,l,r,u,l,l,l,d,l,u,u,r,u,u,u,d,l,u,u,d,l,r,u,d,l,d,u,d,u,r,r,l,d,r,r,r,u,u,l,u,u,r,l,u,d,r,u,r,u,l,r,l,r,l,r,r,u,u,l,r,u,u,u,d,r,r,d,d,r,l,l,l,d,d,l,l,u,d,d,d,l,l,r,l,l,u,l,u,l,r,r,u,r,r,r,l,d,r,l,d,l,l,r,u,r,d,u,l,l,d,u,l,r,u,u,r,l,r,u,d,r,u,r,l,r,r,d,l,l,d,d,u,r,l,d,d,l,u,d,l,r,l,u,u,r,d,r,d,r,d,d,u,u,r,d,d,l,d,d,d,r,u,d,u,l,d,l,r,d,r,d,d,u,r,d,l,u,d,d,d,r,u,d,l,u,d,l,u,l,u,l,r,u,u,r,l,r,u,u,u,d,d,r,l,d,u,l,l,l,u,d,l,u,l,d,u,u,d,l,d,l,r,r,l,l,l,r,l,d,u,d,r,u,u,l,d,l,d,r,d,l,r,r,d,l,d,l,u,l,u,u,d,r,r,u,d,d,d,r,d,l,r,l,d,l,r,d,u,d,r,u,l,d,r,d,u,r,r,u,u,l,l,u,d,u,r,u,r,u,u,d,r,d,r,l,r,r,d,r,r,d,r,d,d,d,d,l,l,r,u,r,u,l,d,u,r,d,l,u,d,l,u,u,l,d,d,l,l,l,d,u,l,u,u,u,u,l,d,u,d,r,d,u,r,l,u,r,d,l,d,d,l,d,d,u,u,l,r,l,u,u,d,l,d,r,u,d,r,u,r,u,r,r,d,d,l,u,r,u,r,d,r,l,r,l,u,u,u,u,r,l,l,r,r],
       [u,u,u,u,u,r,r,r,u,r,l,l,r,r,d,r,l,l,d,u,u,u,u,d,d,d,r,l,r,r,d,r,u,u,l,d,u,u,r,u,r,d,r,l,l,r,r,r,d,r,l,l,u,d,u,r,u,d,l,d,u,r,u,r,r,l,u,d,l,l,l,d,r,d,u,d,r,d,r,l,d,r,u,d,u,d,d,u,u,l,l,u,u,l,l,d,u,d,u,d,d,r,d,u,u,u,d,l,u,l,u,d,u,u,l,l,u,u,u,l,u,r,r,u,d,u,u,l,d,u,d,d,r,d,u,r,r,l,d,d,u,r,l,r,d,l,u,l,d,d,r,u,d,u,d,r,d,u,l,l,r,l,r,l,l,u,u,d,d,u,r,l,u,u,d,l,r,u,u,d,d,l,l,r,u,u,r,d,u,d,l,l,d,r,u,r,l,d,u,r,d,l,r,d,u,u,d,l,r,l,l,r,l,r,u,r,r,u,d,r,r,l,r,d,r,u,r,r,r,u,u,l,l,u,d,l,d,u,r,d,l,d,d,d,u,u,d,r,u,u,u,d,u,l,l,l,r,d,r,r,d,r,l,u,r,d,d,r,u,u,u,d,r,r,u,u,d,l,u,d,d,d,r,r,r,r,r,l,r,l,d,l,l,d,d,l,r,d,u,r,r,u,r,l,l,l,u,l,u,r,u,l,l,u,l,r,l,l,d,d,l,d,r,l,d,u,l,l,d,l,d,d,d,r,l,u,d,d,d,u,d,u,d,r,r,l,r,d,l,l,d,u,l,u,l,r,l,r,u,r,d,l,u,d,d,l,r,u,d,r,l,u,u,r,r,u,r,d,u,r,d,r,r,d,r,u,l,u,d,u,r,r,l,u,l,u,u,r,d,r,l,d,l,r,u,d,l,u,d,r,u,r,l,u,d,u,u,u,l,r,r,l,r,r,r,u,l,r,r,r,l,r,l,r,l,u,l,u,l,d,r,u,u,d,l,r,l,l,r,l,l,l,u,r,u,u,d,l,u,d,l,r,u,r,u,d,r,r,l,d,l,l,u,l,u,d,r,u,d,r,l,l,l,r,l,l,d,l,l,d,u,d,r,r,u,r,r,l,d,l,u,u,u,u,r,d,d,d,u,u,r,l,l,r,r,d,r,u,u,u,r,r,r,d,r,u,d,l,l,u,l,d,l,l,d,l,u,d,r,r,d,l,l,d,d,l,d,u,r,l,l,d,l,l,d,l,l,l,d,r],
       [l,r,d,u,l,u,u,u,d,l,r,u,u,u,d,u,r,u,u,u,l,l,u,r,d,r,u,r,d,r,r,d,d,d,l,r,l,r,u,u,l,d,l,r,r,u,d,d,l,l,u,u,r,l,d,r,l,l,r,u,u,l,l,u,d,l,u,d,u,d,r,d,r,d,l,u,u,d,u,l,l,l,l,r,d,d,u,d,r,r,r,u,r,l,r,d,d,l,r,l,d,r,l,u,l,l,l,r,u,u,u,l,u,r,d,d,l,l,l,l,r,u,r,u,u,d,d,d,l,d,u,d,d,d,d,l,l,l,u,r,l,u,u,u,u,r,l,r,u,d,r,r,l,l,l,u,u,u,l,r,d,u,u,r,d,l,r,d,d,d,u,d,l,l,r,d,u,l,u,r,u,r,u,u,l,u,d,l,l,r,r,u,r,d,l,u,u,l,u,u,d,u,l,l,u,d,u,u,d,u,r,l,r,u,l,r,l,l,d,l,u,u,l,l,r,r,u,d,d,u,l,r,u,l,d,u,r,r,l,r,r,l,u,l,l,l,r,r,d,l,l,d,d,l,d,u,d,d,d,u,d,l,r,u,u,r,u,d,u,u,u,d,d,l,r,r,d,l,r,u,d,r,l,l,r,d,r,d,l,u,r,r,l,u,d,u,u,l,d,r,r,u,d,r,r,u,d,l,l,l,l,r,u,r,r,r,r,r,u,u,l,u,l,l,l,r,d,r,d,u,d,r,d,d,u,r,d,l,d,d,u,u,r,r,u,r,l,d,r,r,u,d,l,r,l,l,r,r,u,r,u,l,u,u,d,d,d,l,l,l,r,d,r,l,u,l,l,d,l,d,d,u,l,d,l,u,u,d,r,u,r,u,l,l,d,l,l,l,l,d,r,l,r,r,l,u,r,l,r,u,l,r,d,l,l,u,l,u,d,r,d,r],
       [r,u,r,r,r,u,d,l,u,r,r,u,r,l,u,r,d,d,r,u,l,l,d,r,d,r,d,r,r,u,l,r,r,d,l,d,d,l,d,u,u,u,r,u,u,l,l,r,r,d,r,l,d,r,r,d,r,u,l,l,u,r,r,r,u,l,l,l,d,u,l,d,d,d,d,l,u,l,r,u,u,l,r,u,r,u,d,u,r,d,u,d,r,l,r,u,l,l,l,r,d,u,r,d,d,u,d,d,r,d,l,u,r,r,u,r,u,u,r,d,l,d,d,d,d,d,u,r,u,r,r,u,r,l,l,l,d,d,l,d,r,r,d,u,d,d,l,l,l,d,r,r,l,d,d,u,u,u,l,d,l,l,d,r,u,u,r,u,d,d,r,r,l,d,u,u,l,r,r,d,d,u,d,r,u,u,l,r,l,d,l,r,l,r,u,u,r,l,l,d,r,d,l,d,r,l,u,r,u,l,d,l,u,l,d,r,u,l,u,r,l,l,r,r,l,l,d,d,d,u,r,l,r,u,u,r,u,u,l,u,l,r,l,l,l,u,l,u,d,u,l,u,u,u,l,d,r,u,r,u,d,d,d,u,u,d,d,r,d,u,d,u,d,r,d,l,l,l,r,d,u,l,r,l,d,l,r,r,d,r,r,l,r,d,l,d,d,u,l,u,l,r,l,r,u,u,d,d,u,d,r,r,l,u,d,r,d,u,u,u,d,r,l,l,l,r,r,l,r,u,d,r,r,l,r,u,u,d,d,l,d,u,r,l,d,r,r,r,u,d,r,r,d,u,d,d,l,r,d,d,l,u,l,l,d,l,u,r,l,u,u,d,l,u,d,l,u,d,l,d,r,r,l,r,r,r,u,l,d,r,l,r,d,u,u,r,l,u,u,l,r,d,u,r,u,d,u,u,d,d,u,r,d,d,l,r,r,r,l,u,u,u,d,u,r,u,l,r,u,r,l,d,r,u,r,u,l,d,d,u,d,d,l,u,d,l,d,l,u,r,d,d,r,r,d,d,u,d,u,u,u,r,l,d,l,r,d,d,l,d,u,l,d,u,l,d,d,d,l,d,r,d,d,l,u,u,r,d,u,l,l,u,d,r,r,r,u,l,r,l,d,d,l,r,d,r,l,r,u,r,l,u,l,l,l,d,u,l,l,u,u,d,u,r,l,d,d,u,l,r,r,d,d,u,u,l,d,r,l,d,l,u,l,r,r,d,u,l,u,d,u,u,u,r,u,u,r,d,d,d,r,u,l,r,l,r,d,l,r,r,u,r,r],
       [u,d,d,d,r,l,d,r,d,u,l,d,r,l,r,d,u,d,d,l,d,l,l,d,d,l,u,u,u,r,d,d,d,l,u,d,r,d,u,d,l,d,u,r,l,u,u,r,u,d,u,u,l,u,u,u,l,d,u,u,r,l,u,l,l,r,l,u,d,l,l,u,r,u,u,u,u,l,r,l,r,l,l,l,r,r,l,u,l,l,d,r,u,u,l,u,r,r,l,l,u,d,u,d,u,r,u,l,l,l,r,r,r,r,l,r,u,u,l,l,r,d,r,d,r,r,d,d,l,u,d,r,r,u,u,l,u,d,r,u,u,l,r,d,l,r,d,r,r,l,r,r,d,r,r,r,l,u,l,r,u,l,u,u,r,r,r,u,l,l,r,r,r,u,r,u,d,u,u,r,r,l,l,d,d,d,u,d,d,u,l,u,u,l,r,u,r,u,d,u,d,u,d,r,l,d,l,u,u,l,u,d,d,l,l,l,l,d,r,l,l,r,l,d,u,l,l,l,r,l,l,d,l,u,u,d,u,r,d,l,l,r,u,r,u,u,d,d,d,d,l,l,u,d,d,r,l,u,u,d,u,d,r,d,r,l,l,u,r,u,r,l,u,r,r,d,l,d,d,d,u,l,u,u,r,u,r,u,r,r,l,u,u,d,u,d,l,d,l,d,d,u,l,l,u,r,u,d,l,r,l,d,l,r,l,d,l,d,u,d,u,l,u,r,d,u,d,r,l,u,r,r,r,u,l,l,d,d,d,r,d,r,u,r,d,d,l,d,l,u,l,u,d,r,u,u,l,d,l,u,l,r,d,u,u,u,r,l,u,l,d,r,r,u,l,l,u,d,l,d,r,l,r,d,d,u,d,u,r,r,r,u,r,r,l,r,d,u,u,l,u,r,u,u,d,l,u,l,d,l,r,u,u,u,l,u,d,r,d,r,r,u,d,u,d,u,l,l,d,d,r,l,r,d,l,u,r,d,l,r,l,u,u,r,d,r,u,d,r,d,r,u,d,l,u,l,r,u,d,d,r,d,l,l,l,r,l,u,r,r,u,r,r,l,d,d,d,u,d,d,l,r,d,r,r,r,u,l,l,u,u,d,u,l,u,r,d,l,d,r,d,d,d,l,d,u,r,r,l,r,r,d,l,l,d,d,l,u,l,u,l,r,r,d,u,d,u,u,d,u,u,l,r,d,r,r,d,u,r,d,d,d,d,u,u,d,d,l,u,d,d,u,u,l,d,r,d,d,u,l,l,u,u,u,u,r,r,r,u,u,u,r,r,u,l,d,r,r,d,u,r,r,l,u,l,l,d,u]]).
