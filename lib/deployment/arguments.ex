defmodule EarendilCli.Deployment.Arguments do
  alias EarendilCli.Common.Path, as: Path
  alias EarendilCli.Config.Agent, as: Config

  defp add_arguments(args, %{arguments: arguments}) do
    if not is_nil(arguments),
      do: args ++ ["--arguments"] ++ split_arguments(arguments),
      else: args
  end

  defp split_arguments(arguments) do
    String.split(arguments, " ")
  end

  def make(task) do
    config = Config.get()

    args = [
      "contract",
      "deploy",
      "--project=.",
      "--recall-nonce",
      "--gas-limit=#{task.gas_limit}",
      "--pem=#{Path.expand(config.pem)}"
    ]

    add_arguments(args, task) ++
      [
        "--send",
        "--outfile=interaction.json",
        "--proxy=#{config.proxy}",
        "--chain=#{config.chain}"
      ]
  end
end
