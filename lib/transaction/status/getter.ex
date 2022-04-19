defmodule EarendilCli.Transaction.Status.Getter do
  alias EarendilCli.Common.Context, as: Context
  alias EarendilCli.Common.Result, as: Result
  alias EarendilCli.Config.Agent, as: Config

  defp get_tx_hash(called_function) do
    Context.get(called_function)
			|> Map.get(:result)
			|> Map.get(:emittedTransactionHash)
  end

  defp make_arguments(function) do
    default = ["tx", "get", "--hash"]
    config = Config.get()

    default ++ [get_tx_hash(function)] ++ ["--proxy", "#{config.proxy}"]
  end

  defp extract_transaction(transaction) do
    transaction[:transactionOnNetwork]
  end

  def get(function) do
    task = fn -> System.cmd("erdpy", make_arguments(function)) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, task)
      |> Task.await(:infinity)
      |> Result.parse
      |> extract_transaction
  end
end
