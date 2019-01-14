% Define the function for an applier actor, which has a state S, holding a value,
% and receives a function f from other actors: if S = f(S), it sends back the result S and ends it computation;
% otherwise sends back a message to state that the condition S = f(S) has not been reached.

-module(fixpoint).
-export([fix/2]).

applier(State) ->
    receive
        {Sender, F} -> NewState = F(State),
                       if NewState =:= State -> Sender!{self(), State};
                          true -> Sender!{self(), no}, applier(NewState)
                       end
    end.

loop(Applier, Function) ->
    Applier!{self(), Function},
    receive
        {Applier, Result} -> if Result =:= no -> loop(Applier, Function);
                                true -> Result
                             end
    end.

fix(Function, Value) ->
    Applier = spawn(?MODULE, applier, [Value]),
    loop(Applier, Function).
