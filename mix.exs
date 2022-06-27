defmodule Earendil.MixProject do
  use Mix.Project

  def project do
    [
      app: :earendil,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      escript: [main_module: Earendil],
      releases: [
        earendil: [
          steps: [:assemble, &Bakeware.assemble/1],
          strip_beams: Mix.env() == :prod,
          overwrite: true
        ]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger],
      mod: {Earendil.Main, []}
    ]
  end

  defp deps do
    [
      {:poison, "~> 5.0"},
      {:shorter_maps, "~> 2.0"},
      {:ex_cli, "~> 0.1.0"},
      {:bakeware, "~> 0.2.3"}
    ]
  end

  defp package do
    [
      name: "earendil",
      description: "Cli app meant to ease interation with Elrond SCs",
      licenses: ["Apache-2.0"],
      links: %{
        "GitHub" => "https://github.com/nerds-sh/earendil-cli"
      }
    ]
  end

  def release do
    [
      earendil: [
        bakeware: [
          compression_level: 18,
          start_command: "daemon"
        ]
      ]
    ]
  end
end
