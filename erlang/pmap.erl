-module(pmap).
-export([map/2, runit/3, double/1]).

runit(Proc, F, X) -> Proc ! {self(), F(X)}.

map(F, L) ->
    W = lists:map(fun(X) -> spawn(?MODULE, runit, [self(), F, X]) end, L),
    lists:map(fun (P) ->
                      receive
                          {P, V} -> V
                      end
              end, W).

double(X) -> 2 * X.
