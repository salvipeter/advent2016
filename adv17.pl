passcode(vkjiggvb).

door_state(X, open) :- member(X, [b,c,d,e,f]), !.
door_state(_, locked).

locks(Path, Locks) :-
    reverse(Path, Reversed),
    atom_chars(Atom, Reversed),
    upcase_atom(Atom, Upper),
    passcode(P),
    atom_concat(P, Upper, String),
    md5_hash(String, MD5, []),
    atom_chars(MD5, [U,D,L,R|_]),
    maplist(door_state, [U,D,L,R], Locks).

rooms(X-Y, [X-Y1,X-Y2,X1-Y,X2-Y]) :-
    X1 is X - 1, X2 is X + 1,
    Y1 is Y - 1, Y2 is Y + 1.

shortest(Shortest) :- shortest(0-0, []-0, []-none, L-_), reverse(L, Shortest).

% shortest(X-Y, CP-CL, CBP-CBL, SP-SL)
%     X-Y is the current position
%     CP/CBP/SP are the current/current-best/shortest paths (reversed)
%     CL/CBL/SL are the current/current-best/shortest path lengths
shortest(X-Y, _, _, _) :- ( X < 0 ; Y < 0 ; X > 3 ; Y > 3 ), !, fail.
shortest(_, _-Length, _-Best, _) :- number(Best), Length >= Best, !, fail.
shortest(3-3, Path, _, Path).
shortest(Pos, Path-Length, Best, Path1) :-
    locks(Path, Locks), rooms(Pos, Rooms),
    try_rooms(Locks, [u,d,l,r], Rooms, Path-Length, Best, Path1).

% try_rooms(Ls, Ds, Rs, CP-CL, CBP-CBL, SP-SL)
%     Ls, Ds, Rs are 4-element lists corresponding a given door
%     - Ls: locked / open
%     - Ds: direction (u/d/l/r)
%     - Rs: room position (X-Y, may be outside [0,3]x[0,3])
try_rooms([], [], [], _, Best, Best).
try_rooms([locked|Ls], [_|Ds], [_|Rs], Path, Best, Path1) :-
    try_rooms(Ls, Ds, Rs, Path, Best, Path1).
try_rooms([open|Ls], [D|Ds], [R|Rs], Path-Length, Best, Path1) :-
    Length1 is Length + 1,
    ( shortest(R, [D|Path]-Length1, Best, Shortest),
      try_rooms(Ls, Ds, Rs, Path-Length, Shortest, Path1)
    ; try_rooms(Ls, Ds, Rs, Path-Length, Best, Path1)
    ).

adv17(X) :- shortest(S), atom_chars(A, S), upcase_atom(A, X), !.

% Part 2

longest(Longest) :- longest(0-0, []-0, []-none, _-Longest).

longest(X-Y, _, _, _) :- ( X < 0 ; Y < 0 ; X > 3 ; Y > 3 ), !, fail.
longest(3-3, Path-Length, _-Best, Path-Length) :- !,
    ( number(Best) -> Length > Best ; true ).
longest(Pos, Path-Length, Best, Path1) :-
    locks(Path, Locks), rooms(Pos, Rooms),
    try_rooms1(Locks, [u,d,l,r], Rooms, Path-Length, Best, Path1).

% Exactly the same as in part 1, but calls "longest" instead of "shortest"
try_rooms1([], [], [], _, Best, Best).
try_rooms1([locked|Ls], [_|Ds], [_|Rs], Path, Best, Path1) :-
    try_rooms1(Ls, Ds, Rs, Path, Best, Path1).
try_rooms1([open|Ls], [D|Ds], [R|Rs], Path-Length, Best, Path1) :-
    Length1 is Length + 1,
    ( longest(R, [D|Path]-Length1, Best, Longest),
      try_rooms1(Ls, Ds, Rs, Path-Length, Longest, Path1)
    ; try_rooms1(Ls, Ds, Rs, Path-Length, Best, Path1)
    ).

adv17b(X) :- longest(X), !.
