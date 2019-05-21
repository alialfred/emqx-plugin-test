%% Copyright (c) 2013-2019 EMQ Technologies Co., Ltd. All Rights Reserved.
%%
%% Licensed under the Apache License, Version 2.0 (the "License");
%% you may not use this file except in compliance with the License.
%% You may obtain a copy of the License at
%%
%%     http://www.apache.org/licenses/LICENSE-2.0
%%
%% Unless required by applicable law or agreed to in writing, software
%% distributed under the License is distributed on an "AS IS" BASIS,
%% WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
%% See the License for the specific language governing permissions and
%% limitations under the License.

-module(emqx_plugin_test_app).

-behaviour(application).

-emqx_plugin(?MODULE).

-export([ start/2
        , stop/1
        ]).

emqx_ctl:register_cmd(cmd, {emqx_cli_demo, cmd}, []).

start(_StartType, _StartArgs) ->
    ok = emqx_access_control:register_mod(auth, emqx_auth_demo, []),
    ok = emqx_access_control:register_mod(acl, emqx_acl_demo, []),
    {ok, Sup} = emqx_plugin_test_sup:start_link(),
    emqx_plugin_test:load(application:get_all_env()),
    {ok, Sup}.

stop(_State) ->
    emqx_plugin_test:unload().

