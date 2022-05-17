defmodule Earendil.Transaction.Logger do
  alias Earendil.Common.Utils, as: Utils
  alias Earendil.Common.Context, as: Context
  import Earendil.Transaction.Status

  defp get_tx_hash(called_function) do
    Context.get(called_function)
    |> Map.get(:result)
    |> Map.get(:emittedTransactionHash)
  end

  defp display(transaction, function) do
    IO.puts(Utils.green_text("Transaction sent successfully"))
    IO.puts("\tFunction: #{Utils.yellow_text(function)}")
    IO.puts("\tHash: #{Utils.yellow_text(get_tx_hash(function))}")
    IO.puts("\tReceiver: #{Utils.yellow_text(transaction.receiver)}")
    IO.puts("\tSender: #{Utils.yellow_text(transaction.sender)}")
    IO.puts("\tNonce: #{Utils.yellow_text(transaction.nonce)}")
    IO.puts("\tValue: #{Utils.yellow_text(transaction.value)}")
  end

  def log(%{function: function}) do
    pool(function)
    |> display(function)
  end
end
