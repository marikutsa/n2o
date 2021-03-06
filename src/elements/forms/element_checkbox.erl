-module(element_checkbox).
-author('Rusty Klophaus').
-include_lib("n2o/include/wf.hrl").
-compile(export_all).

reflect() -> record_info(fields, checkbox).

render_element(Record) -> 
    Id = Record#checkbox.id,
    CheckedOrNot = case Record#checkbox.checked of
        true -> <<"checked">>;
        _ -> <<"not_checked">>
    end,
    case Record#checkbox.postback of
        undefined -> ignore;
        Postback -> wf:wire(Id, #event { type=change, postback=Postback, validation_group=Id, delegate=Record#checkbox.delegate })
    end,

    Icons = [
      wf_tags:emit_tag(<<"span">>, [], [
        {<<"class">>, <<"first-icon fui-checkbox-unchecked">>}
      ]),
      wf_tags:emit_tag(<<"span">>, [], [
        {<<"class">>, <<"second-icon fui-checkbox-checked">>}
      ])
    ],
    Label = [
      wf_tags:emit_tag(<<"span">>, Icons, [{<<"class">>, <<"icons">>}]),
      wf_tags:emit_tag(<<"input">>, [
            {<<"name">>, Record#checkbox.html_name},
            {<<"id">>,   Id},
            {<<"type">>, <<"checkbox">>},
            {<<"data-toggle">>, <<"checkbox">>},
            {<<"value">>, Record#checkbox.value},
            {CheckedOrNot, true}
      ]),
      Record#checkbox.body
    ],
    wf_tags:emit_tag(<<"label">>, Label, [
      {<<"class">>, Record#checkbox.class},
      {<<"style">>, Record#checkbox.style},
      {<<"for">>, Id}
    ]).
