defmodule EarendilCli.Query.Dependencies do
  alias EarendilCli.Query.Arguments, as: Arguments

  def ensure() do
    function = fn -> System.cmd("npm", ["install"], Arguments.cmd()) end

    Task.Supervisor.async(EarendilCli.Task.Supervisor, function)
      |> Task.await(:infinity)
  end
end