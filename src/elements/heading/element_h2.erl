-module(element_h2).
-include_lib("n2o/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, h2).

render_element(Record) -> 
  wf_tags:emit_tag(<<"h2">>, wf:render(Record#h2.body), [
    {<<"id">>, Record#h2.id},
    {<<"class">>, Record#h2.class},
    {<<"style">>, Record#h2.style}
  ]).
