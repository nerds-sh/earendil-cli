defmodule EarendilCli.Setup do
  defmacro __using__(_opts) do
    quote do
      import EarendilCli.Setup.Application
      use EarendilCli.Setup.Cli
    end
  end
end
