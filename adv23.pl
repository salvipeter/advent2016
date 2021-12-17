fact(0, 1).
fact(N, X) :- N > 0, N1 is N - 1, fact(N1, X0), X is N * X0.

% N = 7 for part 1, N = 12 for part 2.
adv23(N, X) :- fact(N, F), X is F + 77 * 87, !.

% Simulator - maybe this will be useful later

run(Ps, I, R, X) :-
    nth0(I, Ps, C), !,
    command(C, Ps, I, R, X).
run(_, _, R, A) :- member(a-A, R).

get(X, _, X) :- number(X), !.
get(X, R, A) :- member(X-A, R).

set(X, V, R, [X-V|R1]) :- select(X-_, R, R1).

toggle(cpy(X,Y), jnz(X,Y)).
toggle(inc(X),   dec(X)).
toggle(dec(X),   inc(X)).
toggle(jnz(X,Y), cpy(X,Y)).
toggle(tgl(X),   inc(X)).

toggle([C|Ps], 0, [C1|Ps]) :- toggle(C, C1).
toggle([C|Ps], I, [C|Ps1]) :- I > 0, I1 is I - 1, toggle(Ps, I1, Ps1).

command(cpy(A,B), Ps, I, R, X) :-
    get(A, R, V),
    set(B, V, R, R1),
    I1 is I + 1,
    run(Ps, I1, R1, X).
command(inc(A), Ps, I, R, X) :-
    get(A, R, V),
    V1 is V + 1,
    set(A, V1, R, R1),
    I1 is I + 1,
    run(Ps, I1, R1, X).
command(dec(A), Ps, I, R, X) :-
    get(A, R, V),
    V1 is V - 1,
    set(A, V1, R, R1),
    I1 is I + 1,
    run(Ps, I1, R1, X).
command(jnz(A,B), Ps, I, R, X) :-
    get(A, R, V),
    ( V =\= 0 -> get(B, R, J), I1 is I + J
    ; I1 is I + 1
    ),
    run(Ps, I1, R, X).
command(tgl(A), Ps, I, R, X) :-
    get(A, R, V), I0 is I + V,
    toggle(Ps, I0, Ps1),
    I1 is I + 1,
    run(Ps1, I1, R, X).
command(_, Ps, I, R, X) :-
    I1 is I + 1,
    run(Ps, I1, R, X).

% First part only
% adv23(X) :- program(Ps), run(Ps, 0, [a-7,b-0,c-0,d-0], X).

program([cpy(a,b),dec(b),cpy(a,d),cpy(0,a),cpy(b,c),inc(a),dec(c),jnz(c,-2),dec(d),jnz(d,-5),dec(b),cpy(b,c),cpy(c,d),dec(d),inc(c),jnz(d,-2),tgl(c),cpy(-16,c),jnz(1,c),cpy(77,c),jnz(87,d),inc(a),inc(d),jnz(d,-2),inc(c),jnz(c,-5)]).
