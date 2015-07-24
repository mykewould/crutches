defmodule Crutches.Monad do
  defmacro __using__(_opts) do
    quote do
      require Crutches.Maybe
      require Crutches.Result
      alias Crutches.Maybe
      alias Crutches.Result

      import Crutches.Monad
    end
  end

  def module(type) do
    cond do
      type == :some || type == :none -> Crutches.Maybe
      type == :ok || type == :error  -> Crutches.Result
      true -> Enum
    end
  end

  def join(monad = {type, _}) do
    apply module(type), :join, [monad]
  end

  def map(monad = {type, _}, function) do
    apply module(type), :map, [monad, function]
  end

  def chain(monad = {type, _}, function) do
    apply module(type), :chain, [monad, function]
  end
end