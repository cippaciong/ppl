-module(exam_2017_02_27).
-export([filter/2, runit/3]).

runit(Proc, F, X) -> 
    Proc ! {self(), F(X), X}.

filter(F, L) ->
    W = lists:map(fun(X) ->
                          spawn(?MODULE, runit, [self(), F, X])
                end, L),
    Res = lists:map(fun (P) ->
                      receive
                          {P, B, V} -> {B, V}
                      end
                  end, W),
    R = [ V || {B, V} <- Res, B =:= true],
    R.
    %lists:foldl(fun(Pid, Res) ->
                        %receive
                            %{Pid, true, Value} -> Res ++ [Value];
                            %{Pid, false, _} -> Res 
                        %end
                %end, [], Pids).




