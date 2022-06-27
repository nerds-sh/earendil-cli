defmodule Earendil.Setup.Cli do
  defmacro __using__(_opts) do
    quote do
      use ExCLI.DSL, mix_task: :earendil, escript: true

      name("earendil")
      description("Ease of life tool for Elrond SCs")

      long_description(~s"""
      Cli meant to describe smart contract deployments, transactions and queries
      """)
    end
  end
end
