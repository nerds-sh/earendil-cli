alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Transaction.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Transaction.Arguments, as: Arguments
  alias EarendilCli.Common.Utils, as: Utils
  alias EarendilCli.Common.Result, as: Result
  alias EarendilCli.Transaction.Logger, as: Logger

  defp make_cmd_options do
    [
      stderr_to_stdout: true,
      parallelism: true,
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", Arguments.make(task), make_cmd_options()) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  def run(task) do
    start_process(task)
      |> Task.await(:infinity)
      |> Result.parse
      |> Result.register(task.function)

    Utils.apply_delay(task)
    Logger.log(task)
  end
end
