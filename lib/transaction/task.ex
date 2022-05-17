alias Earendil.Protocols.Task, as: Protocol
alias Earendil.Transaction.Model, as: Model

defimpl Protocol, for: Model do
  alias Earendil.Transaction.Arguments, as: Arguments
  alias Earendil.Common.Utils, as: Utils
  alias Earendil.Common.Result, as: Result
  alias Earendil.Transaction.Logger, as: Logger

  defp make_cmd_options do
    [
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", Arguments.make(task), make_cmd_options()) end

    Task.Supervisor.async(Earendil.Task.Supervisor, function)
  end

  def run(task) do
    start_process(task)
    |> Task.await(:infinity)
    |> Result.parse()
    |> Result.register(task.function)

    Utils.apply_delay(task)
    Logger.log(task)
  end
end
