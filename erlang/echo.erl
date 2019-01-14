-module(echo).
-export([go/0, loop/0]).

go() ->
    Pid2 = spawn(echo, loop, []), % spawn(module, function, [args])
    Pid2 ! {self(), hello}, % current process sends its pid (self) and hello to Pid2
    receive
        {Pid2, Msg} ->
            io:format("P1 ~w~n", [Msg])
    end,
    Pid2 ! stop.

loop() ->
    receive
        {From, Msg} ->
            From ! {self(), Msg},
            loop();
        stop ->
            true
    end.
    

