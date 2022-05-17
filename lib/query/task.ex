alias Earendil.Protocols.Task, as: Protocol
alias Earendil.Query.Model, as: Model

defimpl Protocol, for: Model do
  alias Earendil.Query.Dependencies, as: Dependencies
  alias Earendil.Query.Arguments, as: Arguments
  alias Earendil.Query.Logger, as: Logger
  alias Earendil.Common.Utils, as: Utils
  alias Earendil.Common.Result, as: Result

  defp start_process(task) do
    function = fn -> System.cmd("node", Arguments.make(task.function), Arguments.cmd()) end

    Task.Supervisor.async(Earendil.Task.Supervisor, function)
  end

  def run(task) do
    Dependencies.ensure()

    start_process(task)
    |> Task.await(:infinity)
    |> Kernel.elem(0)
    |> Poison.decode!
    |> Result.register(task.function)

    Utils.apply_delay(task)
    Logger.log(task)
  end
end
