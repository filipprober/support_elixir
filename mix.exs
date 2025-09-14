defmodule SupportElixir.MixProject do
  use Mix.Project

  def project do
    [
      app: :support,
      version: "0.3.2",
      elixir: "~> 1.18",
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      package: package(),
      name: "Support",
      description: "A collection of helper methods for Elixir projects.",
      docs: [
        main: "readme",
        extras: ["README.md", "CHANGELOG.md"]
      ]
    ]
  end

  def application do
    [
      extra_applications: [:logger]
    ]
  end

  def package do
    [
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/filipprober/support_elixir"
      }
    ]
  end

  defp deps do
    [
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end
end
