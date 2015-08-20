defmodule Crutches.Format do
  defmacro __using__(_opts) do
    quote do
      alias Crutches.Format

      alias Format.List
      alias Format.Number
      alias Format.Integer
    end
  end
end
