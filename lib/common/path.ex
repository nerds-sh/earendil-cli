defmodule EarendilCli.Common.Path do
  use Agent

  def register(path) do
    Agent.start_link(fn -> path end, name: __MODULE__)
  end

  def get() do
    Agent.get(__MODULE__, & &1)
    |> Path.expand()
    |> Path.dirname()
  end

  def expand(path) do
    case Path.type(path) do
      :relative -> Path.expand(path, get())
      :absolute -> Path.expand(path)
    end
  end
end
