defmodule EarendilCli.Common.Parser do
  defp read_file(path) do
    case File.read(Path.expand(path)) do
      {:ok, body} -> body
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end

  defp decode(json, mapper) do
    case Poison.decode(json, as: mapper.(), keys: :atoms) do
      {:ok, json} -> json
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end

  def parse(path, mapper) do
    read_file(path) |> decode(mapper)
  end
end
