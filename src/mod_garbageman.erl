-module(mod_garbageman).

-behaviour(gen_mod).

-include("logger.hrl").

-export([
  start/2,
  stop/1,
  collect/0,
  collect_top_n/1,
  mod_opt_type/1,
  depends/2
]).

-include("ejabberd.hrl").

start(_Host, _Opts) ->
	?INFO_MSG("Starting Mod mod_garbageman", [] ),
	ok.

stop(_Host) ->
  	ok.

collect() ->
	?DEBUG("Starting mod_garbageman collect", [] ),
	[erlang:garbage_collect(P) || P <- processes()],
	ok.

collect_top_n(N) ->
	?DEBUG("Starting mod_garbageman collect_top_n", [] ),
 	lists:sublist(
  		lists:usort(
      		fun({K1,V1},{K2,V2}) -> {V1,K1} =< {V2,K2} end,
      		[try
           		{_,Pre} = erlang:process_info(Pid, binary),
           		erlang:garbage_collect(Pid),
           		{_,Post} = erlang:process_info(Pid, binary),
           		{Pid, length(Post)-length(Pre)}
       		catch
           		_:_ -> {Pid, 0}
       		end || Pid <- processes()]),
  		N),
	ok.

mod_opt_type(_) -> [].
depends(_Host, _Opts) -> [].
