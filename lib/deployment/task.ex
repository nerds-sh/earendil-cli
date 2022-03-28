alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Deployment.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Deployment.Builder, as: Builder
  alias EarendilCli.Deployment.Arguments, as: Arguments
  import EarendilCli.Interaction.Parser
  import EarendilCli.Deployment.ContractAgent

  defp make_cmd_options(path) do
    [
      cd: path,
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", Arguments.make(task), make_cmd_options(task.path)) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  defp log_result(%{contract: contract, hash: hash}) do
    IO.puts("Contract deployed!")
    IO.puts("\tAddress: #{contract}")
    IO.puts("\tTransaction hash: #{hash}")
  end

  def run(task) do
    Builder.run(task.path)

    shite = start_process(task) |> Task.await(:infinity)
    IO.inspect(shite)

    output = parse(task)
    log_result(output)
    set(output.contract)
    :timer.sleep(task.delay)
  end
end
