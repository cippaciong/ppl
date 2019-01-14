-module(exam_2017_07_05).
-export([activate/2, test/0, leafy/1, branchy/3]).

leafy(Val) ->
    receive
        {ask, Pid} -> Pid ! {self(), Val}
    end.

branchy(Left, Right, Fn) ->
    receive
        {ask, Pid} ->
            Left ! {ask, self()},
            Right ! {ask, self()},

            receive
                {Right, Val2} -> RVal = Val2
            end,
            receive
                {Left, Val1} -> LVal = Val1
            end,

            Pid ! {self(), Fn(LVal, RVal)}
    end.

activate({leaf, Val}, _) ->
    spawn(?MODULE, leafy, [Val]);
activate({branch, Left, Right}, Fn) ->
    spawn(?MODULE, branchy, [activate(Left, Fn), activate(Right, Fn), Fn]).


test() ->
    T1 = {branch, {branch, {leaf, 1}, {leaf, 2}}, {leaf, 3}},
    A1 = activate(T1, fun min/2),
    A1 ! {ask, self()},
    receive
        {A1, V} -> V
    end.


                
