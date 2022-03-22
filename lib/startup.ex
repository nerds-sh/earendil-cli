defmodule EarendilCli.Startup do
  def register_supervisor() do
    children = [
      {Task.Supervisor, name: EarendilCli.Task.Supervisor},
    ]

    opts = [strategy: :one_for_one, name: EarendilCli.Supervisor]

    Supervisor.start_link(children, opts)
  end

end
