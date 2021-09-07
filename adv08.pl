width(50).
height(6).

turn_on(_, Ymax, 0, Ymax, L, L) :- !.
turn_on(Xmax, Ymax, Xmax, Y, L, L1) :- !,
    Y < Ymax, Y1 is Y + 1,
    turn_on(Xmax, Ymax, 0, Y1, L, L1).
turn_on(Xmax, Ymax, X, Y, L, L1) :-
    X < Xmax, X1 is X + 1,
    turn_on(Xmax, Ymax, X1, Y, [X-Y|L], L1).

rotate_row(Y, _, Xmax, Xmax, A, L, L1) :- !,
    delete(L, _-Y, L0),
    append(A, L0, L1).
rotate_row(Y, N, Xmax, X, A, L, L1) :-
    X < Xmax, X1 is X + 1,
    ( member(X-Y, L) -> Xd is (X + N) mod Xmax, rotate_row(Y, N, Xmax, X1, [Xd-Y|A], L, L1)
    ; rotate_row(Y, N, Xmax, X1, A, L, L1)
    ).

rotate_col(X, _, Ymax, Ymax, A, L, L1) :- !,
    delete(L, X-_, L0),
    append(A, L0, L1).
rotate_col(X, N, Ymax, Y, A, L, L1) :-
    Y < Ymax, Y1 is Y + 1,
    ( member(X-Y, L) -> Yd is (Y + N) mod Ymax, rotate_col(X, N, Ymax, Y1, [X-Yd|A], L, L1)
    ; rotate_col(X, N, Ymax, Y1, A, L, L1)
    ).

swipe([], L, L) :- !.
swipe([rec(X,Y)|Ds], L, L1) :- turn_on(X, Y, 0, 0, L, L0), swipe(Ds, L0, L1).
swipe([row(Y,N)|Ds], L, L1) :- width(W), rotate_row(Y, N, W, 0, [], L, L0), swipe(Ds, L0, L1).
swipe([col(X,N)|Ds], L, L1) :- height(H), rotate_col(X, N, H, 0, [], L, L0), swipe(Ds, L0, L1).

adv08(X) :-
    data(D), swipe(D, [], L),
    sort(L, S), length(S, X).

display(_, Ymax, 0, Ymax, _) :- !.
display(Xmax, Ymax, Xmax, Y, L) :-
    Y < Ymax, Y1 is Y + 1,
    nl,
    display(Xmax, Ymax, 0, Y1, L).
display(Xmax, Ymax, X, Y, L) :-
    X < Xmax, X1 is X + 1,
    ( member(X-Y, L) -> write('#')
    ; write('.')
    ),
    display(Xmax, Ymax, X1, Y, L).

adv08b :-
    data(D), swipe(D, [], L),
    width(W), height(H), display(W, H, 0, 0, L).

data([rec(1,1),row(0,5),rec(1,1),row(0,6),rec(1,1),row(0,5),rec(1,1),row(0,2),rec(1,1),row(0,5),rec(2,1),row(0,2),rec(1,1),row(0,4),rec(1,1),row(0,3),rec(2,1),row(0,7),rec(3,1),row(0,3),rec(1,1),row(0,3),rec(1,2),row(1,13),col(0,1),rec(2,1),row(0,5),col(0,1),rec(3,1),row(0,18),col(13,1),col(7,2),col(2,3),col(0,1),rec(17,1),row(3,13),row(1,37),row(0,11),col(7,1),col(6,1),col(4,1),col(0,1),rec(10,1),row(2,37),col(19,2),col(9,2),row(3,5),row(2,1),row(1,4),row(0,4),rec(1,4),col(25,3),row(3,5),row(2,2),row(1,1),row(0,1),rec(1,5),row(2,10),col(39,1),col(35,1),col(29,1),col(19,1),col(7,2),row(4,22),row(3,5),row(1,21),row(0,10),col(2,2),col(0,2),rec(4,2),col(46,2),col(44,2),col(42,1),col(41,1),col(40,2),col(38,2),col(37,3),col(35,1),col(33,2),col(32,1),col(31,2),col(30,1),col(28,1),col(27,3),col(26,1),col(23,2),col(22,1),col(21,1),col(20,1),col(19,1),col(18,2),col(16,2),col(15,1),col(13,1),col(12,1),col(11,1),col(10,1),col(7,1),col(6,1),col(5,1),col(3,2),col(2,1),col(1,1),col(0,1),rec(49,1),row(2,34),col(44,1),col(40,2),col(39,1),col(35,4),col(34,1),col(30,4),col(29,1),col(24,1),col(15,4),col(14,1),col(13,3),col(10,4),col(9,1),col(5,4),col(4,3),row(5,20),row(4,20),row(3,48),row(2,20),row(1,41),col(47,5),col(46,5),col(45,4),col(43,5),col(41,5),col(33,1),col(32,3),col(23,5),col(22,1),col(21,2),col(18,2),col(17,3),col(16,2),col(13,5),col(12,5),col(11,5),col(3,5),col(2,5),col(1,5)]).
