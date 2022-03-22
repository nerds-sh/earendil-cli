alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Query.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Deployment.ContractAgent, as: Contract

  defp make_cmd_options do
    [
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp add_step_args(%{arguments: step_args}, args) do
    if not is_nil(step_args), do: args ++ ["--arguments=#{step_args}"], else: args
  end

  defp make_arguments(task) do
    args = [
      "--verbose",
      "contract",
      "query",
      Contract.get(),
      "--function=#{task.function}",
    ]

    args = add_step_args(task, args)

    args ++ [
      "--proxy=#{task.config.proxy}",
      "--send",
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", make_arguments(task), make_cmd_options()) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  defp log(task) do
    IO.puts("Query called successfully!")
    IO.puts("\tCalled function: #{task.function}")
  end

  def run(task) do
    start_process(task) |> Task.await(:infinity)
    log(task)
    :timer.sleep(task.delay)
  end
end
