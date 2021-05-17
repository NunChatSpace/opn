defmodule Reborn.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Ecto repository
      Reborn.Repo,
      # Start the Telemetry supervisor
      RebornWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: Reborn.PubSub},
      # Start the Endpoint (http/https)
      RebornWeb.Endpoint
      # Start a worker by calling: Reborn.Worker.start_link(arg)
      # {Reborn.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Reborn.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    RebornWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
