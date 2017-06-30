defmodule Crutches do
  @moduledoc """
  Utility library for Elixir, designed to complement the standard library
  bundled with the language. This project aims to provide extra functions that
  can be useful in most projects, but haven't made it into the standard library
  yet. Similar to and inspired by [ActiveSupport](https://github.com/rails/rails/tree/master/activesupport)

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

  @doc ~S"""
    An object is blank if it's false, empty, or a whitespace string.

    For example, false, "", '', "\n", nil, [], {} and %{} are all blank.

    ## Examples

      iex> Crutches.blank?("")
      true

      iex> Crutches.blank?("Hello")
      false

      iex> Crutches.blank?([])
      true

      iex > Crutches.blank?({1, 2})
      false
  """
  def blank?(term) do
    Crutches.Protocols.Blankable.blank?(term)
  end

  @doc """
  Opposite of `blank?`
  """
  def present?(term) do
    !blank?(term)
  end
end
