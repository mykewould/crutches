defmodule Crutches.Mixfile do
  use Mix.Project

  def project do
    [app: :crutches,
     version: "0.0.5",
     elixir: "~> 1.0",
     build_embedded: Mix.env == :prod,
     start_permanent: Mix.env == :prod,
     deps: deps,
     description: "An Elixir toolbelt freely inspired from Ruby's ActiveSupport",
     package: [contributors: ["Michael Wood", "Kash Nouroozi", "Maurizio Del Corno",
                              "nawns", "Laurens Duijvesteijn", "Joel Meador",
                              "Sonny Scroggin", "Louis Pilfold", "Alexis Mas"],
               licenses: ["MIT"],
               links: %{"GitHub" => "https://github.com/mykewould/crutches"}]]
  end

  # Configuration for the OTP application
  #
  # Type `mix help compile.app` for more information
  def application do
    [applications: [:logger]]
  end

  # Dependencies can be Hex packages:
  #
  #   {:mydep, "~> 0.3.0"}
  #
  # Or git/path repositories:
  #
  #   {:mydep, git: "https://github.com/elixir-lang/mydep.git", tag: "0.1.0"}
  #
  # Type `mix help deps` for more examples and options
  defp deps do
    [{:inch_ex,    only: :docs},
     {:ex_doc,     only: :docs},
     {:earmark,    only: :docs},
     {:benchfella, only: :dev}]
  end
end
