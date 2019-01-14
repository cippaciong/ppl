-module(exam_2018_09_05).
-export([repeater/2, create_pipe/2, create_pipe/1, test/0]).

% Define a function create_pipe, which takes a list of names and creates
% a process of each element of the list, each process registered as its name in the list;
% e.g. with [one, two], it creates two processes called ‘one’ and ‘two’.
% The processes are “connected” (like in a list, there is the concept of “next process”)
% from the last to the first, e.g. with [one, two, three], the process structure
% is the following: three → two → one → self
% this means that the next process of ‘three’ is ‘two’, and so on;
% self is the process that called create_pipe.
% Each process is a simple repeater, showing on the screen its name
% and the received message, then sends it to the next process.
% Each process ends after receiving the ‘kill’ message, unregistering itself.

repeater(Name, Next) ->
    receive
        kill ->
            io:format("Process ~w unregistering and killing itself~n", [Name]),
            case Next =:= self() of
                false -> Next ! kill
            end,
            unregister(Name);
        Msg ->
            io:format("Process ~w received message ~w~n", [Name, Msg]),
            case Next =:= self() of
                false -> Next ! Msg
            end,
            repeater(Name, Next)
    end.


create_pipe([], Last) -> Last;
create_pipe(List, Next) ->
    [X|XS] = List,
    Receiver = spawn(?MODULE, repeater, [X, Next]),
    register(X, Receiver),
    create_pipe(XS, Receiver).


create_pipe(List) ->
    [X|XS] = List,
    First = spawn(?MODULE, repeater, [X, self()]),
    register(X, First),
    create_pipe(XS, First).

test() ->
    Last = create_pipe([one, two, three]),
    Last ! "Woot",
    timer:sleep(1000),
    Last ! kill.

