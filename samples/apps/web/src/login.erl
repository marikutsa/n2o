-module(login).
-compile(export_all).
-include_lib("n2o/include/wf.hrl").

title() -> [ <<"Login">> ].

main() ->
    Title = wf:render(title()),
    Body = wf:render(body()),
  [ #dtl{file = "login", bindings=[{title,Title},{body,Body}]} ].

body() -> [ #span{id=display}, #br{},
            #span{body="Login: "}, #textbox{id=user}, #br{},
            #span{body="Password: "}, #password{id=pass},
            #button{id=login,body="Login",postback=login,source=[user,pass]} ].

event(init) -> [];

event(login) -> User = wf:q(user), wf:update(display,User), wf:user(User), wf:redirect("index").
