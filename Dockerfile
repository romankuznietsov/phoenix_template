FROM elixir:1.18

RUN apt-get update -qq && apt-get install -y inotify-tools postgresql-client
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs

WORKDIR /app

ENTRYPOINT [ "/bin/bash" ]
