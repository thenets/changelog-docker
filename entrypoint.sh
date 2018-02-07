#!/bin/sh

# Configure database
# ... I don't know what should I do here...
cd /home/easyelixir/changelog.com/config
rm dev.exs test.exs
ln -s prod.exs dev.exs
ln -s prod.exs test.exs

# Start server
cd /home/easyelixir/changelog.com
mix ecto.migrate
mix phx.server