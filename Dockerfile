FROM elixir:1.6-alpine

# Download dependencies
RUN apk add --no-cache git yarn gcc clang make musl-dev inotify-tools

ENV USER_NAME=elixir
ENV USER_HOME=/app
ENV APP=$USER_HOME

# Create $USER_NAME user
RUN adduser $USER_NAME -D -h $USER_HOME -u 1000 && \
    chown -R 1000.1000 $USER_HOME

# Add project data
ADD src/ $APP/
RUN chown -R elixir.elixir $APP

# Setup app
USER $USER_NAME
WORKDIR $APP
RUN mix local.hex --force && \
    mix deps.update cmark && \
    mix deps.get --only-prod && \
    mix local.rebar --force && \
    mix compile

ADD ./entrypoint.sh /entrypoint.sh
ENTRYPOINT [ "/entrypoint.sh" ]