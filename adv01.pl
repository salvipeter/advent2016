% -*- mode: prolog -*-

turn(r, v(X,Y), v(Y,Y1)) :- Y1 is -X.
turn(l, v(X,Y), v(X1,X)) :- X1 is -Y.

step(p(X,Y), v(DX,DY), N, p(X1,Y1)) :- X1 is X + DX * N, Y1 is Y + DY * N.

go([], _, P, P).
go([d(T,N)|S], D, P, Q) :- turn(T, D, D1), step(P, D1, N, P1), go(S, D1, P1, Q).

adv01(S) :-
    directions(Ds),
    go(Ds, v(1,0), p(0,0), p(X,Y)),
    S is abs(X)+abs(Y).

%% Part 2

step1(P, _, 0, P).
step1([P|Ps], _, _, [P]) :- member(P, Ps).
step1([p(X,Y)|Ps], v(DX,DY), N, Q) :-
    N > 0, X1 is X + DX, Y1 is Y + DY, N1 is N - 1,
    step1([p(X1,Y1),p(X,Y)|Ps], v(DX,DY), N1, Q).

go1([d(T,N)|S], D, P, Q) :-
    turn(T, D, D1),
    step1(P, D1, N, P1),
    ( P1 = [Q] ; go1(S, D1, P1, Q) ).

adv01b(S) :-
    directions(Ds),
    go1(Ds, v(1,0), [p(0,0)], p(X,Y)),
    S is abs(X)+abs(Y).

directions([d(r,2), d(l,1), d(r,2), d(r,1), d(r,1), d(l,3), d(r,3), d(l,5), d(l,5), d(l,2), d(l,1), d(r,4), d(r,1), d(r,3), d(l,5), d(l,5), d(r,3), d(l,4), d(l,4), d(r,5), d(r,4), d(r,3), d(l,1), d(l,2), d(r,5), d(r,4), d(l,2), d(r,1), d(r,4), d(r,4), d(l,2), d(l,1), d(l,1), d(r,190), d(r,3), d(l,4), d(r,52), d(r,5), d(r,3), d(l,5), d(r,3), d(r,2), d(r,1), d(l,5), d(l,5), d(l,4), d(r,2), d(l,3), d(r,3), d(l,1), d(l,3), d(r,5), d(l,3), d(l,4), d(r,3), d(r,77), d(r,3), d(l,2), d(r,189), d(r,4), d(r,2), d(l,2), d(r,2), d(l,1), d(r,5), d(r,4), d(r,4), d(r,2), d(l,2), d(l,2), d(l,5), d(l,1), d(r,1), d(r,2), d(l,3), d(l,4), d(l,5), d(r,1), d(l,1), d(l,2), d(l,2), d(r,2), d(l,3), d(r,3), d(l,4), d(l,1), d(l,5), d(l,4), d(l,4), d(r,3), d(r,5), d(l,2), d(r,4), d(r,5), d(r,3), d(l,2), d(l,2), d(l,4), d(l,2), d(r,2), d(l,5), d(l,4), d(r,3), d(r,1), d(l,2), d(r,2), d(r,4), d(l,1), d(l,4), d(l,4), d(l,2), d(r,2), d(l,4), d(l,1), d(l,1), d(r,4), d(l,1), d(l,3), d(l,2), d(l,2), d(l,5), d(r,5), d(r,2), d(r,5), d(l,1), d(l,5), d(r,2), d(r,4), d(r,4), d(l,2), d(r,5), d(l,5), d(r,5), d(r,5), d(l,4), d(r,2), d(r,1), d(r,1), d(r,3), d(l,3), d(l,3), d(l,4), d(l,3), d(l,2), d(l,2), d(l,2), d(r,2), d(l,1), d(l,3), d(r,2), d(r,5), d(r,5), d(l,4), d(r,3), d(l,3), d(l,4), d(r,2), d(l,5), d(r,5)]).
