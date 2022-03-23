defmodule EarendilCli.Common.Utils do
  def read_file(path) do
    case File.read(Path.expand(path)) do
      {:ok, body} -> body
      {:error, reason} -> IO.puts("Error: #{reason}")
    end
  end

  def apply_delay(task) do
    if not is_nil(task.delay), do: :timer.sleep(task.delay)
  end
end
