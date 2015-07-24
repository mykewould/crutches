defmodule Crutches.Maybe do
  def of(value) when is_nil(value), do: none
  def of({:none, _}), do: none
  def of(value), do: some(value)

  def none, do: {:none, nil}
  def some(value), do: {:some, value}

  def unwrap({:none, _}), do: nil
  def unwrap({:some, value}), do: value

  defmacro none?(maybe) do
    quote do: elem(unquote(maybe), 0) == :none
  end

  defmacro some?(maybe) do
    quote do: elem(unquote(maybe), 0) == :some
  end

  def join(maybe) when none?(maybe), do: none
  def join({:some, {:some, value}}), do: join({:some, value})
  def join({:some, value}), do: {:some, value}

  def map({:none, _}, function) when is_function(function), do: none
  def map({:some, value}, function) when is_function(function) do
    value |> function.() |> of
  end

  def chain({:none, _}, function) when is_function(function), do: none
  def chain({:some, value}, function) when is_function(function) do
    value |> function.() |> join
  end
end