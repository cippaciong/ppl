-module(exam_2017_09_01).
-export([worker/3, listener/2, parfind/2, test/0]).

% Define a parfind (parallel find) operation, which takes a list of lists L
% and a value x, and parallely looks for x in every list of L
% The idea is to launch one process for each list, searching for x.
% If x is found, parfind returns one of the lists containing x;
% otherwise, it returns false.
%
% E.g.
% parfind([[1,2,3],[4,5,6],[4,5,9,10]], 4) could return either [4,5,6] or [4,5,9,10];
% parfind([[1,2,3],[4,5,6],[4,5,9,10]], 7) is false.




worker(List, Value, Pid) ->
    case lists:member(Value, List) of
        true ->
            Pid ! {self(), true, List};
        false ->
            Pid ! {self(), false, []}
    end.

listener(0, Main) -> Main ! {self(), false};
listener(Count, Main) ->
    receive
        {_Pid, true, L} -> 
            Main ! {self(), L};
        {_Pid, false, _ } -> listener(Count - 1, Main)
    end.


parfind(List, Value) ->
    Listener = spawn(?MODULE, listener, [length(List), self()]),
    lists:map(fun(L) ->
                      spawn(?MODULE, worker, [L, Value, Listener])
              end, List),
    receive
        {Listener, V} -> V
    end.

test() ->
    io:format("~w~n", [parfind([[1,2,3],[4,5,6],[4,5,9,10]], 4)]), % [4,5,6] or [4,5,9,10];
    io:format("~w~n", [parfind([[1,2,3],[4,5,6],[4,5,9,10]], 7)]). % false.
