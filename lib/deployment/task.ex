alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Deployment.Model, as: Model

defimpl Protocol, for: Model do
  alias EarendilCli.Builder, as: Builder
  import EarendilCli.Interaction.Parser
  import EarendilCli.Deployment.ContractAgent

  defp make_cmd_options(path) do
    [
      cd: Path.expand(path),
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp make_arguments(task) do
    [
      "--verbose",
      "contract",
      "deploy",
      "--project=.",
      "--recall-nonce",
      "--gas-limit=#{task.gas_limit}",
      "--pem=#{task.config.pem}",
      "--arguments=#{task.arguments}",
      "--send",
      "--outfile=interaction.json",
      "--proxy=#{task.config.proxy}",
      "--chain=#{task.config.chain}"
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", make_arguments(task), make_cmd_options(task.path)) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  defp log_result(%{contract: contract, hash: hash}) do
    IO.puts("Contract deployed!")
    IO.puts("\tAddress: #{contract}")
    IO.puts("\tTransaction hash: #{hash}")
  end

  def run(task) do
    Builder.run(task.path)

    start_process(task) |> Task.await(:infinity)

    output = parse(task)
    log_result(output)
    set(output.contract)
    :timer.sleep(task.delay)
  end
end
