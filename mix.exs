defmodule Crutches.Mixfile do
  use Mix.Project

  def project do
    [
      app: :crutches,
      version: "2.0.0",
      elixir: "~> 1.6",
      build_embedded: Mix.env() == :prod,
      start_permanent: Mix.env() == :prod,
      deps: deps(),
      description: "An Elixir toolbelt freely inspired from Ruby's ActiveSupport",
      package: [
        maintainers: [
          "Michael Wood",
          "Kash Nouroozi",
          "Maurizio Del Corno",
          "nawns",
          "Laurens Duijvesteijn",
          "Joel Meador",
          "Sonny Scroggin",
          "Louis Pilfold",
          "Alexis Mas",
          "Bryan Enders"
        ],
        licenses: ["MIT"],
        links: %{"GitHub" => "https://github.com/mykewould/crutches"}
      ]
    ]
  end

  def application do
    [applications: [:logger]]
  end

  defp deps do
    [
      {:inch_ex, only: :docs},
      {:ex_doc, only: :docs},
      {:earmark, only: :docs},
      {:benchfella, only: :dev}
    ]
  end
end
