defmodule EarendilCli.Setup.Application do
  import ShorterMaps
  alias EarendilCli.Step.Handlers, as: Handlers
  alias EarendilCli.Common.Context, as: Context

  def register_context() do
    Context.initialize()
  end

  def register_supervisor() do
    children = [
      {Task.Supervisor, name: EarendilCli.Task.Supervisor}
    ]

    opts = [strategy: :one_for_one, name: EarendilCli.Supervisor]

    Supervisor.start_link(children, opts)
  end

  def run_steps(~M{config, steps}) do
    handle_step = &Handlers.handle_step/2

    steps
    |> Enum.each(fn step -> handle_step.(config, step) end)
  end
end
