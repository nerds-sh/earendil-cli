defmodule EarendilCli.Interaction.Parser do
  import ShorterMaps
  import EarendilCli.Common.Parser
  alias EarendilCli.Common.Path, as: RelativePath
  alias EarendilCli.Interaction.Model, as: Interaction

  def parse(task) do
    mapper = fn -> ~M{%Interaction} end
    raw = parse(RelativePath.expand("#{task.path}/interaction.json"), mapper)

    ~M{contract: raw.contractAddress, hash: raw.emittedTransactionHash}
  end
end
