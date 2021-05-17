FROM bitwalker/alpine-elixir-phoenix:latest

WORKDIR /src/assets
COPY assets .

WORKDIR /src/config
COPY config .
# COPY deps .
WORKDIR /src/lib
COPY lib .

WORKDIR /src/priv
COPY priv .

WORKDIR /src
COPY mix.exs .
COPY mix.lock .
COPY .formatter.exs .
COPY package-lock.json .
COPY package.json .

WORKDIR /src/node_modules
COPY node_modules .

WORKDIR /src/assets
RUN npm install -g npm@7.13.0
RUN npm install

WORKDIR /src
RUN export SECRET_KEY_BASE=IoxkIHMfSlhguAV5wRRyk5sfZtEMq7hl5dw3josqyQLN4Hdok/f11D1zKKekbguF
RUN mix deps.get --only prod
RUN mix phx.digest
RUN mix compile

WORKDIR /src/assets
RUN npm run deploy 
