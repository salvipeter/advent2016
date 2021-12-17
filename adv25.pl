% Pseudocode translation:
%
%   repeat
%     n = a + 231 * 11
%     while n > 0
%       print n % 2
%       n /= 2
%
% The program outputs the binary digits of (a + 231 * 11),
% from lowest to highest, and starts over when finished.
% Since 231 * 11 = 2541 = 100111101101,
% and we need to output - 101010101010 = 2730,
% we have the following equation for the value of a:

adv25(X) :- X is 2730 - 231 * 11.
