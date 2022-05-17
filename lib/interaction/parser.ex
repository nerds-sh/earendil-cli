defmodule Earendil.Interaction.Parser do
  import ShorterMaps
  import Earendil.Common.Parser
  alias Earendil.Common.Path, as: RelativePath
  alias Earendil.Interaction.Model, as: Interaction

  def parse(task) do
    mapper = fn -> ~M{%Interaction} end
    raw = parse(RelativePath.expand("#{task.path}/interaction.json"), mapper)

    ~M{contract: raw.contractAddress, hash: raw.emittedTransactionHash}
  end
end
