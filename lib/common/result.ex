defmodule Earendil.Common.Result do
  alias Earendil.Common.Context, as: Context

  defp filter(array) do
    not_info = fn element -> not String.contains?(element, "INFO") end

    Enum.filter(array, not_info)
  end

  def parse({result, 0}) do
    String.split(result, ~r{\n})
    |> filter
    |> Enum.join()
    |> Poison.decode!(keys: :atoms)
  end

  def register(value, function) do
    Context.update(String.to_atom(function), value)
  end
end
