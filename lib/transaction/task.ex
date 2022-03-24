alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Transaction.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Transaction.Arguments, as: Arguments
  alias EarendilCli.Common.Utils, as: Utils

  defp make_cmd_options do
    [
      stderr_to_stdout: true,
      parallelism: true,
      into: IO.stream()
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", Arguments.make(task), make_cmd_options()) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  defp log(task) do
    IO.puts("Transaction sent successfully!")
    IO.puts("\tCalled function: #{task.function}")
  end

  def run(task) do
    start_process(task) |> Task.await(:infinity)
    log(task)
    Utils.apply_delay(task)
  end
end
