defmodule EarendilCli.Step.Parser do
  import ShorterMaps
  import EarendilCli.Common.Parser
  alias EarendilCli.Config.Model, as: Config
  alias EarendilCli.Step.Model, as: Step

  def parse(path) do
    mapper = fn -> ~M{config: Config, steps: [Step]} end

    parse(path, mapper)
  end
end
