#!/bin/sh

# ENV
APP=/app

# Install dependencies
cd $APP

# Configure database
# ... I don't know what should I do here...
cd $APP/config
rm dev.exs test.exs
ln -s prod.exs dev.exs
ln -s prod.exs test.exs

# Run database migration
cd $APP
mix ecto.migrate

# Start server
cd $APP
mix phx.server