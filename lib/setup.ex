defmodule Earendil.Setup do
  defmacro __using__(_opts) do
    quote do
      import Earendil.Setup.Application
      use Earendil.Setup.Cli
    end
  end
end
