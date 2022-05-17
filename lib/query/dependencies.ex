defmodule Earendil.Query.Dependencies do
  alias Earendil.Query.Arguments, as: Arguments

  def ensure() do
    function = fn -> System.cmd("npm", ["install"], Arguments.cmd()) end

    Task.Supervisor.async(Earendil.Task.Supervisor, function)
      |> Task.await(:infinity)
  end
end