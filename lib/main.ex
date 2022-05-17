defmodule Earendil.Main do
  use Bakeware.Script

  @impl Bakeware.Script
  def main(args) do
    ExCLI.run(Earendil, args)

    0
  end
end
