defmodule EarendilCli.Query.Logger do
  alias EarendilCli.Common.Utils, as: Utils
  alias EarendilCli.Common.Context, as: Context

  defp get_result(function), do: Context.get(function)

  defp extract_result(result), do: result[:result]

  defp encode_result(result), do: Poison.encode!(result, pretty: true)

  defp dispay(result, function) do
    IO.puts(Utils.green_text("Query called successfully!"))
    IO.puts("\tFunction: #{Utils.yellow_text(function)}")
    IO.puts("\tResult: \n#{Utils.yellow_text(encode_result(result))}")
  end

  def log(%{function: function}) do
    get_result(function)
    |> extract_result
    |> dispay(function)
  end
end
