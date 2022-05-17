defmodule Earendil.Setup.Application do
  import ShorterMaps
  alias Earendil.Step.Handlers, as: Handlers
  alias Earendil.Common.Context, as: Context
  alias Earendil.Config.Agent, as: ConfigAgent

  def register_context() do
    Context.initialize()
  end

  def register_supervisor() do
    children = [
      {Task.Supervisor, name: Earendil.Task.Supervisor}
    ]

    opts = [strategy: :one_for_one, name: Earendil.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def run_steps(~M{config, steps}) do
    handle_step = &Handlers.handle_step/1
    ConfigAgent.set(config)

    steps
    |> Enum.each(handle_step)
  end
end
