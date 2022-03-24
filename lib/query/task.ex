alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Query.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Query.Arguments, as: Arguments
  alias EarendilCli.Common.Utils, as: Utils

  defp make_cmd_options do
    [
      into: IO.stream(),
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", Arguments.make(task), make_cmd_options()) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  defp log(task) do
    IO.puts("Query called successfully!")
    IO.puts("\tCalled function: #{task.function}")
  end

  def run(task) do
    start_process(task) |> Task.await(:infinity)
    log(task)
    Utils.apply_delay(task)
  end
end
