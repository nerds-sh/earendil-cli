defmodule Earendil.Step.Parser do
  import ShorterMaps
  import Earendil.Common.Parser
  alias Earendil.Config.Model, as: Config
  alias Earendil.Step.Model, as: Step

  def parse(path) do
    mapper = fn -> ~M{config: Config, steps: [Step]} end

    parse(path, mapper)
  end
end
