defmodule Earendil.Config.Model do
  @derive [Poison.Encoder]

  defstruct [:pem, :proxy, :chain]
end
