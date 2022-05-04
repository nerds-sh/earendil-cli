defmodule EarendilCli.Config.Agent do
  use Agent

  def set(value) do
    Agent.start_link(fn -> value end, name: __MODULE__)
  end

  def get do
    Agent.get(__MODULE__, & &1)
  end
end
