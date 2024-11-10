#!/bin/bash
# We assume you already have ASDF installed and
# also the Erlang and Elixir plugins
set -e
ERLANG_VERSION=27.1.2
ELIXIR_VERSION=1.17.3-otp-27
PHOENIX_VERSION=1.7.0

echo Install Erlang and Elixir
asdf install erlang $ERLANG_VERSION
asdf install elixir $ELIXIR_VERSION

echo Use the Erlang and Elixir versions in the current shell
source ~/.asdf/asdf.sh
asdf shell erlang $ERLANG_VERSION
asdf shell elixir $ELIXIR_VERSION

echo Set the versions in .tool_versions
echo erlang $ERLANG_VERSION > .tool_versions
echo elixir $ELIXIR_VERSION >> .tool_versions

echo Install the correct phx.new version
mix archive.uninstall phx_new | echo No older version found
mix archive.install hex phx_new $PHOENIX_VERSION

echo Create the hello_world project
pushd ..
test -d hello_world && rm -rf hello_world
mix phx.new hello_world

echo Remove old files
popd
rm -r *
git checkout -- README.md LICENSE

echo Move hello_world into place
mv ../hello_world/README.md "README hello_world.md"
mv ../hello_world/* .
mv ../hello_world/.gitignore .
mv ../hello_world/.formatter.exs .

echo Done
