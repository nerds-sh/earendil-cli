defmodule Earendil.Common.Utils do
  alias Earendil.Common.Path, as: RelativePath

  defp read(path) do
    case File.read(path) do
      {:ok, body} -> body
      {_, reason} -> IO.puts("Error: #{reason}")
    end
  end

  def read_file(path) do
    Path.expand(path) |> read
  end

  def read_file(path, :relative) do
    RelativePath.expand(path) |> read
  end

  def apply_delay(task) do
    if not is_nil(task.delay), do: :timer.sleep(task.delay)
  end

  def green_text(message), do: "#{IO.ANSI.green()}#{message}#{IO.ANSI.reset()}"

  def yellow_text(message), do: "#{IO.ANSI.yellow()}#{message}#{IO.ANSI.reset()}"
end
