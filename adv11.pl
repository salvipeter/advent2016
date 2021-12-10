% 1. szintrol indulunk
% egyszerre egy szintet lephetunk fel/le
% pontosan 1 vagy 2 dolgot vihetunk mindig magunkkal
% nem szabad: microchip(X) es generator(Y) egy szinten, kiveve ha generator(X) is ott van
% cel: mindent felvinni a 4. szintre
% minimum lepesszam?

% Paper-and-pencil solution
% -------------------------
% Generators are uppercase, microchips are lowercase; ^/_ means going up/down.
% Moving n > 1 items requires 2n-3 steps.
%
%  4
%  3 bcde
%  2 BCDE
% *1 Aa
%
% Aa^ a^  [2]
%
%  4
% *3 abcde
%  2 ABCDE
%  1
%
% cde_ cde_ c^ [7]
%
%  4
%  3 ab
% *2 ABCcDE
%  1 de
%
% AB^ Aa^ A_ A_ AE^ AE^ E_ E_ DE^ DE^ D_ Bb^ E_ [13]
%
%  4 AaBb
% *3 DE
%  2 Cc
%  1 de
%
% DE^ D_ D_ Cc^ Cc^ E_ E_ DE^ DE^ [9]
%
% *4 AaBbCcDE
%  3
%  2
%  1 de
%
% a_ a_ a_ ade^ ade^ ade^ [12]
%
% => 2 + 7 + 13 + 9 + 12 = 43 steps
%
% The optimal solution cannot be shorter than 27 steps
% (Aa^ [1] + AaBCDE^ [9] + AaBbCcDdEe^ [17] = 27)

floors([1-generator(promethium),1-microchip(promethium),
        2-generator(cobalt),2-generator(curium),2-generator(ruthenium),2-generator(plutonium),
        3-microchip(cobalt),3-microchip(curium),3-microchip(ruthenium),3-microchip(plutonium)]).
% floors([1-microchip(hydrogen),1-microchip(lithium),2-generator(hydrogen),3-generator(lithium)]).

% choose(+N, +F, +Xs, -Ys, -Xs1)
%     Chooses exactly N items from Xs on floor F into Ys;
%     the remaining items are in Xs1.
choose(0, _, L, [], L) :- !.
choose(N, F, [X|Xs], Ys, [X|Xs1]) :- N > 0, choose(N, F, Xs, Ys, Xs1).
choose(N, F, [F-X|Xs], [F-X|Ys], Xs1) :- N > 0, N1 is N - 1, choose(N1, F, Xs, Ys, Xs1).

add(N, X-T, Y-T) :- Y is X + N.

check(L) :- check(4, L).
check(0, _) :- !.
check(N, L) :-
    member(N-microchip(X), L),
    \+ member(N-generator(X), L),
    member(N-generator(_), L),
    !, fail.
check(N, L) :- N1 is N - 1, check(N1, L).

steps(4, L, _, []) :- forall(member(N-_, L), N = 4), !.
steps(F, L, S, [step(F-F1,T)|X]) :-
    length(S, N), N < 43,
    check(L),
    sort(L, L0),
    \+ member(state(F,L0), S),
    ( choose(1, F, L, T, L1) ; choose(2, F, L, T, L1) ),
    ( F > 1, F1 is F - 1,
      maplist(add(-1), T, T1),
      append(T1, L1, L2),
      steps(F1, L2, [state(F,L0)|S], X)
    ; F < 4, F1 is F + 1,
      maplist(add(1), T, T1),
      append(T1, L1, L2),
      steps(F1, L2, [state(F,L0)|S], X)
    ).

adv11(L) :- floors(F), steps(1, F, [], L).%, length(L, X).
