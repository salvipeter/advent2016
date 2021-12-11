% Unfortunately this solution does not scale well [see adv11.cc].

floors([[microchip(hydrogen),microchip(lithium)],
        [generator(hydrogen)],
        [generator(lithium)],
        []]).
% floors([[generator(promethium),microchip(promethium)],
%         [generator(cobalt),generator(curium),generator(ruthenium),generator(plutonium)],
%         [microchip(cobalt),microchip(curium),microchip(ruthenium),microchip(plutonium)],
%         []]).

check(L) :-
    member(microchip(X), L),
    \+ member(generator(X), L),
    member(generator(_), L),
    !, fail.
check(_).

% choose(+N, +Xs, -Ys, -Xs1)
%     Chooses exactly N items from Xs into Ys;
%     the remaining items are in Xs1.
choose(0, Xs, [], Xs) :- !.
choose(N, [X|Xs], Ys, [X|Xs1]) :- N > 0, choose(N, Xs, Ys, Xs1).
choose(N, [X|Xs], [X|Ys], Xs1) :- N > 0, N1 is N - 1, choose(N1, Xs, Ys, Xs1).

replace(1, [_,B,C,D], A, [A,B,C,D]) :- !.
replace(2, [A,_,C,D], B, [A,B,C,D]) :- !.
replace(3, [A,B,_,D], C, [A,B,C,D]) :- !.
replace(4, [A,B,C,_], D, [A,B,C,D]) :- !.

steps(4, [[],[],[],_], _, []) :- !.
steps(F, L, N, [step(F-F1,T)|X]) :-
    N > 0, N1 is N - 1,
    nth1(F, L, Xs),
    ( choose(1, Xs, T, Xs1), check(Xs1)
    ; choose(2, Xs, T, Xs1), check(Xs1)
    ),
    ( F > 1, F1 is F - 1
    ; F < 4, F1 is F + 1
    ),
    nth1(F1, L, Ys),
    append(T, Ys, Ys1),
    check(Ys1),
    replace(F, L, Xs1, L1),
    replace(F1, L1, Ys1, L2),
    steps(F1, L2, N1, X).

adv11(L) :- floors(F), steps(1, F, 11, L).
