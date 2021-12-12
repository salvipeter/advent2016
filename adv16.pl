state([1,1,1,0,1,0,0,0,1,1,0,0,1,0,1,0,0]).

% Trivial version (which does not scale):

take(0, _, []).
take(N, [X|Xs], [X|Ys]) :- N > 0, N1 is N - 1, take(N1, Xs, Ys).

grow(X, Y) :- grow(X, [], Y0), append(X, Y0, Y).
grow([], A, [0|A]).
grow([0|X], A, Y) :- grow(X, [1|A], Y).
grow([1|X], A, Y) :- grow(X, [0|A], Y).

grow_until(N, X, Y) :- length(X, L), L >= N, take(N, X, Y).
grow_until(N, X, Y) :- grow(X, Z), grow_until(N, Z, Y).

checksum(L, X) :- length(L, N), N mod 2 =:= 1, !, atomic_list_concat(L, X).
checksum(L, X) :- checksum_once(L, C), checksum(C, X).

checksum_once([], []).
checksum_once([D,D|L], [1|X]) :- !, checksum_once(L, X).
checksum_once([_,_|L], [0|X]) :- checksum_once(L, X).

adv16(X) :- state(S), grow_until(272, S, S1), checksum(S1, X).

% The checksum and reverse checksum of the initial are:

state_checksums([1,0,0,1,1,1,0,0,x,1,0,0,0,0,1,0,1]).

% Checksums are grown like a dragon curve:
%                                    1
%                  1                                   0
%         1                 0                 1                 0
% 10011100 10000101 10011100 10000101 10011100 10000101 10011100 10000101
% ... which is the checksum of a size-142 disk.

% If we take the first 68 = 17 * 2^2 elements and compute the checksum:
% 10011100110000101110011100010000101110011100110000101010011100010000
% 0 0 1 1 1 1 1 0 1 0 0 1 1 0 1 1 0 1 0 0 1 1 1 1 1 0 0 0 0 1 1 0 1 1
%  1   1   1   0   0   0   0   1   0   1   1   1   0   1   0   0   1

% Here the first 17 elements of the first line is a 34-checksum
%                                   second          68
%                                   third           136

% We can compute the K-th bit of the first line without computing the whole series!

% P. Scott: Taming the Dragon. Mathematics in School 26(1), pp. 2-4, 1997.
% The rule is simple:
% - 0 if there is a 1 before the rightmost 1 in binary representation
% - 1 if there is a 0 before the rightmost 1 in binary representation
dragon(N, 1) :- N mod 4 =:= 1.
dragon(N, 0) :- N mod 4 =:= 3.
dragon(N, D) :- N mod 2 =:= 0, N1 is N // 2, dragon(N1, D).

bit(S, K, D) :- K mod 9 =\= 8, K1 is K mod 18, nth0(K1, S, D).
bit(_, K, D) :- I is (K + 1) // 9, dragon(I, D).

% K-th digit in level L
digit(S, 0, K, D) :- bit(S, K, D), !.
digit(S, L, K, D) :-
    L > 0, L1 is L - 1,
    K1 is K * 2, K2 is K1 + 1,
    digit(S, L1, K1, D1),
    digit(S, L1, K2, D2),
    ( D1 = D2 -> D = 1 ; D = 0 ).

% Note that 272 = 17 * 2^4 and 35651584 = 17 * 2^21.

adv16b(X) :-
    state_checksums(S),
    findall(D, (between(0, 16, K), digit(S, 20, K, D)), L),
    atomic_list_concat(L, X).
