-module(tut).
-export([double/1, fac/1, area/1]).

% Double function
double(X) ->
    2 * X.

% Factorial function
fac(1) ->
    1;
fac(N) ->
    N * fac(N-1).

% Area of squares, circles and triangles
area({square, Size}) ->
    Size * Size;
area({circle, Radius}) ->
    2 * 3.14 * Radius * Radius;
area({triangle, A, B, C}) ->
    S = (A + B + C)/2,
    math:sqrt(S*(S-A)*(S-B)*(S-C));
area(Other) ->
    {invalid_object, Other}.

