defmodule Earendil.Query.Arguments do
  alias Earendil.Deployment.ContractAgent, as: Contract
  alias Earendil.Config.Agent, as: Config

  defp get_priv() do
    :code.priv_dir(:earendil)
  end

  def cmd() do
    [
      cd: "#{get_priv()}/query-decoder",
      stderr_to_stdout: true,
      parallelism: true
    ]
  end

  defp get_env() do
    case Config.get().chain do
      "D" -> "devnet"
      "T" -> "testnet"
      1 -> "mainnet"
    end
  end

  defp get_abi_path(path) do
    expanded = Path.expand(path)

    Path.wildcard("#{expanded}/output/*.abi.json")
    |> Enum.at(0)
  end

  def make(function) do
    contract = Contract.get()
    [
      "index.js",
      get_abi_path(contract.path),
      contract.address,
      get_env(),
      function
    ]
  end
end
