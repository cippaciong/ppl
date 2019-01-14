-module(exam_2017_07_20).
-export([run/1, create_dlist/1, dlist_to_list/1, dmap/2, test/0]).

run(Value) ->
    receive
        {Pid, get} ->
            Pid ! {self(), getack, Value},
            run(Value);
        {Pid, set, NewValue} ->
            Pid ! {self(), setack, NewValue},
            run(NewValue)
    end.

create_dlist(Len) ->
    lists:map(fun(_I) ->
                      spawn(?MODULE, run, [0])
              end, lists:seq(1, Len)).

dlist_to_list(Dlist) ->
    lists:map(fun(Pid) ->
                      Pid ! {self(), get},
                      receive
                          {Pid, getack, Value} -> V = Value
                      end,
                      V
              end, Dlist).

dmap(Dlist, Fn) ->
    lists:map(fun(Pid) ->
                      Pid ! {self(), get},
                      receive
                          {Pid, getack, Value} -> V = Value
                      end,
                      Pid ! {self(), set, Fn(V)},
                      receive
                          {Pid, setack, _} -> done
                      end
              end, Dlist).

test() ->
    Dlist = create_dlist(5),
    _ = dmap(Dlist, fun(X) -> X + 2 end),
    _ = dmap(Dlist, fun(X) -> X * rand:uniform(3) end),
    dlist_to_list(Dlist).

