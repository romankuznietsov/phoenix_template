# Phoenix App Setup Instructions

1. Create `Dockerfile` with the following contents:

```
FROM elixir:1.18

RUN apt-get update -qq && apt-get install -y inotify-tools postgresql-client
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs

WORKDIR /app

ENTRYPOINT [ "/bin/bash" ]
```

2. Create `docker-compose.yml` with the following contents:

```
services:
  app:
    build: .
    environment:
      HISTFILE: /app/.docker_history
    volumes:
      - .:/app
      - mix:/root/.mix
      - deps:/app/deps
      - node_modules:/app/assets/node_modules
      - build:/app/_build
      - assets:/app/priv/assets
    ports:
      - "4000:4000"

volumes:
  mix:
  deps:
  node_modules:
  build:
  assets:
```

3. Launch the app container

4. Install Hex with `mix local.hex`

5. Install Phoenix with `mix archive.install hex phx_new`

6. In the root directory of the container run `mix phx.new app`, agree to install dependencies

7. In `lib/app/application.ex` comment out `App.Repo`

8. In `mix.exs` comment out `test: ["ecto.create --quiet", "ecto.migrate --quiet", "test"],`

10. Launch the container with forwarded ports and start the server with `mix phx.server`
