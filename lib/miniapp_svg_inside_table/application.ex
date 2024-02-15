defmodule MiniappSvgInsideTable.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      MiniappSvgInsideTableWeb.Telemetry,
      MiniappSvgInsideTable.Repo,
      {DNSCluster, query: Application.get_env(:miniapp_svg_inside_table, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: MiniappSvgInsideTable.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: MiniappSvgInsideTable.Finch},
      # Start a worker by calling: MiniappSvgInsideTable.Worker.start_link(arg)
      # {MiniappSvgInsideTable.Worker, arg},
      # Start to serve requests, typically the last entry
      MiniappSvgInsideTableWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: MiniappSvgInsideTable.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    MiniappSvgInsideTableWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
