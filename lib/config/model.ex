defmodule EarendilCli.Config.Model do
  @derive [Poison.Encoder]

  defstruct [:pem, :proxy, :chain]
end
