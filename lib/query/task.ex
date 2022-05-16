alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Query.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Query.Arguments, as: Arguments
  alias EarendilCli.Query.Logger, as: Logger
  alias EarendilCli.Common.Utils, as: Utils
  alias EarendilCli.Common.Result, as: Result
  alias EarendilCli.Config.Agent, as: ConfigAgent

  defp start_process(task) do
    function = fn -> System.cmd("node", Arguments.make(task.function), Arguments.cmd()) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  def run(task) do
    start_process(task)
    |> Task.await(:infinity)
    |> Kernel.elem(0)
    |> Poison.decode!
    |> Result.register(task.function)

    Utils.apply_delay(task)
    Logger.log(task)
  end
end
