defmodule EarendilCli.Main do
  use Bakeware.Script

  @impl Bakeware.Script
  def main(args) do
    ExCLI.run(EarendilCli, args)

    0
  end
end
