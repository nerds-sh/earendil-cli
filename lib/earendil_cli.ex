defmodule EarendilCli do
  import ShorterMaps
  import EarendilCli.Startup
  import EarendilCli.Step.Parser
  alias EarendilCli.Step.Handlers, as: Handlers

  defp run_steps(~M{config, steps}) do
    handle_step = &Handlers.handle_step/2

    steps
      |> Enum.each(fn step -> handle_step.(config, step) end)
  end

  def run do
    register_supervisors()
    steps = parse("~/steps.json")
    run_steps(steps)
  end
end
