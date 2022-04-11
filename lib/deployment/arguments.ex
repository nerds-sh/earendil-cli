defmodule EarendilCli.Deployment.Arguments do
  alias EarendilCli.Common.Path, as: Path

  defp add_arguments(args, %{arguments: arguments}) do
    if not is_nil(arguments), do: args ++ ["--arguments=#{arguments}"], else: args
  end

  def make(task) do
    args = [
      "contract",
      "deploy",
      "--project=.",
      "--recall-nonce",
      "--gas-limit=#{task.gas_limit}",
      "--pem=#{Path.expand(task.config.pem)}",
    ]

    add_arguments(args, task) ++ [
      "--send",
      "--outfile=interaction.json",
      "--proxy=#{task.config.proxy}",
      "--chain=#{task.config.chain}"
    ]
  end
end
