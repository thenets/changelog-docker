FROM elixir:1.6-alpine

ENV USER_NAME=easyelixir
ENV USER_HOME=/home/$USER_NAME/
ENV APP=$USER_HOME/changelog.com

# Download dependencies
RUN apk add --no-cache git yarn gcc clang make musl-dev inotify-tools

# Create $USER_NAME user
RUN adduser $USER_NAME -D -h /home/$USER_NAME -u 1000 && \
    chown -R 1000.1000 $USER_HOME

# Change to $USER_NAME user
USER $USER_NAME

# Download changelog
RUN cd $USER_HOME && \
    git clone https://github.com/thechangelog/changelog.com.git
WORKDIR $APP

# Setup changelog
RUN mix local.hex --force && \
    mix deps.update cmark && \
    mix deps.get --only-prod && \
    mix local.rebar --force && \
    mix compile

CMD ["iex"]