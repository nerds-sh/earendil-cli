defmodule EarendilCli.Test.Utils do
  alias EarendilCli.Deployment.ContractAgent, as: Contract
  def get_contract_address(), do: Contract.get()

  def print_lol(), do: IO.puts("LOOLOLOLOL")
end
