defmodule SondaMeuCredere.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    children = [
      # Start the Telemetry supervisor
      SondaMeuCredereWeb.Telemetry,
      # Start the PubSub system
      {Phoenix.PubSub, name: SondaMeuCredere.PubSub},
      # Start the Endpoint (http/https),
      SondaMeuCredere.Sonda,
      SondaMeuCredereWeb.Endpoint
      # Start a worker by calling: SondaMeuCredere.Worker.start_link(arg)
      # {SondaMeuCredere.Worker, arg}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: SondaMeuCredere.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  def config_change(changed, _new, removed) do
    SondaMeuCredereWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
