defmodule Crutches do
  defmacro __using__(_opts) do
    quote do
      alias Crutches.Enum
      alias Crutches.List
      alias Crutches.Map
      alias Crutches.String
      alias Crutches.Integer

      alias Crutches.Format
    end
  end
end
