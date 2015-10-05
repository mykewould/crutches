defmodule Crutches do
  @moduledoc """
  Crutches is an addition to the Elixir standard library, inspired by
  ActiveSupport. We include a number of utilities that we feel are missing in
  the Elixir standard library.

  Get Crutches by adding the following to your `mix.exs` and afterwards, run
  `mix deps.get`:

      defp deps do
        [{:crutches, "`~> 1.0.0`"}]
      end

  Then, `use Crutches` in a module and find all of our functions and modules
  under the `C` alias. Alternatively, alias it to something you prefer.
  """
  defmacro __using__(_opts) do
    quote do
      alias Crutches,        as: C
      alias Crutches.Format, as: F
    end
  end
end
