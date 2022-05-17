defmodule Earendil.Common.Context do
  import ShorterMaps
  use Agent

  def initialize() do
    Agent.start_link(fn -> [] end, name: __MODULE__)
  end

  def update(function, result) do
    Agent.update(__MODULE__, fn list -> [~M{function, result} | list] end)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end

  defp functions_match(called_function) do
    fn %{function: function} -> function == String.to_atom(called_function) end
  end

  def get(function) do
    match_function = functions_match(function)

    get()
    |> Enum.find(match_function)
  end
end
