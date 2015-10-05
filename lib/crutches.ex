defmodule Crutches do
  defmacro __using__(_opts) do
    quote do
      alias Crutches,        as: C
      alias Crutches.Format, as: F
    end
  end
end
