defmodule EarendilCli.MixProject do
  use Mix.Project

  def project do
    [
      app: :earendil_cli,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  defp deps do
    [
      {:poison, "~> 5.0"},
      {:shorter_maps, "~> 2.0"},
      {:ex_cli, "~> 0.1.0"},
    ]
  end
end
