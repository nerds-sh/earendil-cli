defmodule Earendil.Step.Module do
  @derive [Poison.Encoder]

  defstruct [:type, :options]
end
