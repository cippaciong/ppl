-module(myserver).

server(Data) ->
    receive
        {From, {request, X}} ->
            {R, Data1} = fn(X, Data),
            From ! {myserver, {reply, R}},
            server(Data1)
    end.

-export([request/1])
request(Req) ->
    myserver ! {self(), {request, Req}},
    receive
        {myserver, {reply, Rep}} -> Rep
    end.
