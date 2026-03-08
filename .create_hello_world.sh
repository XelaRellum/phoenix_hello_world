#!/bin/bash
# We assume you already have ASDF installed and
# also the Erlang and Elixir plugins
set -e
ERLANG_VERSION=28.4
ELIXIR_VERSION=1.19.5-otp-28
PHOENIX_VERSION=1.8.4

echo Install Erlang and Elixir
mise use erlang@$ERLANG_VERSION
mise use elixir@$ELIXIR_VERSION

echo Install the correct phx.new version
mix archive.uninstall phx_new | echo No older version found
mix archive.install hex phx_new $PHOENIX_VERSION

echo Create the hello_world project
pushd ..
test -d hello_world && rm -rf hello_world
mix phx.new hello_world

echo Remove old files
popd
mv mise.toml ..
rm -rf *
mv ../mise.toml .
git checkout -- README.md LICENSE

echo Move hello_world into place
mv ../hello_world/README.md "README hello_world.md"
mv ../hello_world/* .
mv ../hello_world/.gitignore .
mv ../hello_world/.formatter.exs .

echo Done
