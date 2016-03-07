defmodule ConsoleTree.Mixfile do
  use Mix.Project

  def project do
    [app: :console_tree,
     version: "0.0.1",
     description: "A simple library to print a text representation of a tree structure, intended for use in a terminal environment.",
     elixir: "~> 1.2",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     package: package,
     deps: deps]
  end

  # Configuration for the OTP application
  #
  # Type "mix help compile.app" for more information
  def application do
    [applications: [:logger]]
  end

  defp deps do
    []
  end

  defp package do
    [
      maintainers: ["Ciarán Walsh"],
      licenses: ["MIT"],
      links: %{
        github: "https://github.com/ciaran/console_tree"
      }
    ]
  end
end
