defmodule Crutches.Format do
  defmacro __using__(_opts) do
    quote do
      alias Crutches.Format.List
      alias Crutches.Format.Number
    end
  end
end
