# Official Elixir release
FROM elixir:1.14

# Install required packages and tools
RUN apt-get update && apt-get install -y wget inotify-tools nodejs npm

# Set working directory as app
WORKDIR /MSC_Pool_Back/mix.exs

# Create an app directory to store our files in
ADD . .

# Install the Phoenix (phx) archive
RUN mix local.hex --force \
  && mix local.rebar --force \
  && wget -O phx_new.ez https://github.com/phoenixframework/archives/raw/master/phx_new.ez \
  && cat ./phx_new.ez \
  && mix archive.install ./phx_new.ez --force


# Install Elixir dependenciess
RUN mix deps.get

# Compile files
RUN mix compile

# Expose port 4000
EXPOSE 4000

CMD ["sh", "-c", "mix clean && mix ecto.drop && mix ecto.setup && mix phx.server"]
