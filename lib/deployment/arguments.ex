defmodule EarendilCli.Deployment.Arguments do
  def make(task) do
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
end
