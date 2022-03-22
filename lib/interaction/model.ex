defmodule EarendilCli.Interaction.Model do
  @derive [Poison.Encoder]

  defstruct [:emittedTransactionHash, :contractAddress]
end
