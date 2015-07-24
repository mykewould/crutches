defmodule Crutches.Result do
  def of(value) when is_nil(value), do: error(value)
  def of(result), do: ok(result)

  def error(value \\ nil), do: {:error, value}
  def ok(value), do: {:ok, value}

  def unwrap({:error, reason}), do: reason
  def unwrap({:ok, result}), do: result

  defmacro error?(result) do
    quote do: elem(unquote(result), 0) == :error
  end

  defmacro ok?(result) do
    quote do: elem(unquote(result), 0) == :ok
  end

  def join({:error, reason}), do: {:error, reason}
  def join({:ok, {:ok, value}}), do: join({:ok, value})
  def join({:ok, value}), do: {:ok, value}

  def map({:error, reason}, _), do: {:error, reason}
  def map({:ok, value}, function) when is_function(function) do
    value |> function.() |> of
  end

  def chain({:error, reason}, _), do: {:error, reason}
  def chain({:ok, value}, function) when is_function(function) do
    value |> function.() |> join
  end
end