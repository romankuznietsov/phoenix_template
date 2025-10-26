# Phoenix App Setup Instructions

1. Create `Dockerfile` with the following contents:

```
FROM elixir:1.19

RUN apt-get update -qq && apt-get install -y inotify-tools postgresql-client

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
      - build:/app/_build
      - assets:/app/priv/assets
    ports:
      - "4000:4000"
    depends_on:
      - postgres

  postgres:
    image: postgres:17.5
    environment:
      POSTGRES_PASSWORD: postgres
    volumes:
      - postgres:/var/lib/postgresql/data

volumes:
  mix:
  deps:
  build:
  assets:
  postgres:
```

3. Launch the app container

4. Install Hex with `mix local.hex`

5. Install Phoenix with `mix archive.install hex phx_new`

6. In the root directory of the container run `mix phx.new app`, agree to install dependencies

7. In `config/dev.exs` and `config/test.exs` set database hostname to `"postges"`.

8. Create the database with `mix ecto.setup`.

7. Launch the container with forwarded ports and start the server with `mix phx.server`
