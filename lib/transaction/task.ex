alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Transaction.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Deployment.ContractAgent, as: Contract
  alias EarendilCli.Common.Utils, as: Utils

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
      "call",
      Contract.get(),
      "--function=#{task.function}",
    ]

    args = add_step_args(task, args)

    args ++ [
      "--gas-limit=#{task.gas_limit}",
      "--proxy=#{task.config.proxy}",
      "--recall-nonce",
      "--send",
      "--chain=#{task.config.chain}",
      "--pem=#{task.config.pem}"
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", make_arguments(task), make_cmd_options()) end

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
