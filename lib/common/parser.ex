defmodule EarendilCli.Common.Parser do
  import EarendilCli.Common.Utils

  defp decode(json, mapper) do
    case Poison.decode(json, as: mapper.(), keys: :atoms) do
      {:ok, json} -> json
      {_, reason} -> IO.puts("Error: #{reason}")
    end
  end

  def parse(path, mapper) do
    read_file(path) |> decode(mapper)
  end
end
