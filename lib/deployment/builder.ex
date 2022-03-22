defmodule EarendilCli.Deployment.Builder do
  defp make_cmd_options(path) do
    [
      cd: Path.expand(path),
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp start_process(path) do
    function = fn -> System.cmd("erdpy", ["contract", "build"], make_cmd_options(path)) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  def run(path) do
    start_process(path) |> Task.await(:infinity)
  end
end
