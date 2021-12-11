fib(1, M, _, M).
fib(N, K1, K2, M) :-
    N1 is N - 1, K3 is K1 + K2,
    fib(N1, K2, K3, M).
fib(N, M) :- fib(N, 1, 1, M).

% - the first part computes the (d+2)-th Fibonacci number (d = 26)
% - the second part adds c * d (c = d = 14)
adv12(X) :- fib(28, F), M is 14 * 14, X is F + M.

% If c is 1 initially, d is increased by c (= 7)
adv12b(X) :- fib(35, F), M is 14 * 14, X is F + M.
