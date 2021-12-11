design(1358).
target(31-39).

wall(X-Y) :-
    design(D),
    N is X*X + 3*X + 2*X*Y + Y + Y*Y + D,
    ones(N, O), O mod 2 =:= 1.
empty(P) :- \+ wall(P).

ones(0, 0).
ones(N, X) :- N > 0, N1 is N // 2, ones(N1, X0), X is X0 + N mod 2.

neighbors(X-Y, X1-Y) :- X1 is X + 1 ; X1 is X - 1.
neighbors(X-Y, X-Y1) :- Y1 is Y + 1 ; Y1 is Y - 1.

valid(X-Y) :- X >= 0, Y >= 0.

routes(P, X) :- findall(Q, (neighbors(P, Q), valid(Q), empty(Q)), X).

steps([], _, N, N) :- !.
steps(Ps, [T-K|Ds], N, X) :-
    target(T),
    ( number(N) -> K < N ; true ), !,
    steps(Ps, [T-K|Ds], K, X).
steps([_-K|Ps], Ds, N, X) :- number(N), K >= N, !, steps(Ps, Ds, N, X).
steps([P-K|Ps], Ds, N, X) :-
    routes(P, R),
    K1 is K + 1,
    update(R, K1, Ds, R1),
    append(R1, Ps, Ps1),
    steps(Ps1, [P-K|Ds], N, X).

update([], _, _, []).
update([P|Ps], K, Ds, [P-K|X]) :-
    ( member(P-K0, Ds) -> K < K0 ; true ), !,
    update(Ps, K, Ds, X).
update([_|Ps], K, Ds, X) :- update(Ps, K, Ds, X).

adv13(X) :- steps([1-1-0], [], none, X).

% This is actually simpler than the first part...
atmost([], Ds, _, N) :- length(Ds, N).
atmost([_-K|Ps], Ds, Max, X) :- K > Max, !, atmost(Ps, Ds, Max, X).
atmost([P-K|Ps], Ds, Max, X) :-
    routes(P, R),
    K1 is K + 1,
    update(R, K1, Ds, R1),
    append(R1, Ps, Ps1),
    ( select(P-_, Ds, Ds1) ; Ds1 = Ds ),
    atmost(Ps1, [P-K|Ds1], Max, X).

adv13b(X) :- atmost([1-1-0], [], 50, X).
