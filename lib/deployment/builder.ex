defmodule Earendil.Deployment.Builder do
  alias Earendil.Common.Path, as: RelativePath

  defp make_cmd_options(path) do
    [
      cd: RelativePath.expand(path),
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp start_process(path) do
    function = fn -> System.cmd("erdpy", ["contract", "build"], make_cmd_options(path)) end

    Task.Supervisor.async(Earendil.Task.Supervisor, function)
  end

  def run(path) do
    start_process(path) |> Task.await(:infinity)
  end
end
