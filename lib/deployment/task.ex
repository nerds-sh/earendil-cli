alias EarendilCli.Protocols.Task, as: Protocol
alias EarendilCli.Deployment.Model, as: Model

defimpl Protocol, for: Model do
  import ShorterMaps
  alias EarendilCli.Deployment.Builder, as: Builder
  alias EarendilCli.Deployment.Arguments, as: Arguments
  alias EarendilCli.Common.Path, as: RelativePath
  alias EarendilCli.Common.Utils, as: Utils
  import EarendilCli.Interaction.Parser
  import EarendilCli.Deployment.ContractAgent

  defp make_cmd_options(path) do
    [
      cd: RelativePath.expand(path),
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp start_process(task) do
    function = fn -> System.cmd("erdpy", Arguments.make(task), make_cmd_options(task.path)) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
  end

  defp log_result(%{contract: contract, hash: hash}) do
    IO.puts(Utils.green_text("Contract Deployed!"))
    IO.puts("\tAddress: #{Utils.yellow_text(contract)}")
    IO.puts("\tTransaction hash: #{Utils.yellow_text(hash)}")
  end

  def run(task) do
    Builder.run(task.path)

    start_process(task) |> Task.await(:infinity)

    output = parse(task)
    log_result(output)
    set(~M{address: output.contract, path: task.path})
    Utils.apply_delay(task)
  end
end
