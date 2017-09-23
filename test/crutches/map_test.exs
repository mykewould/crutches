defmodule Crutches.MapTest do
  alias Crutches.Map
  use ExUnit.Case, async: true
  doctest Crutches.Map

  test "filter" do
    assert Map.filter(%{a: 1, b: nil}, fn({_k, v}) -> !is_nil(v) end) == %{a: 1}
    assert Map.filter(%{a: 1, b: 2}, fn({_k, v}) -> !is_nil(v) end) == %{a: 1, b: 2}
  end

  test "reject" do
    assert Map.reject(%{a: 1, b: nil}, fn({_k, v}) -> is_nil(v) end) == %{a: 1}
    assert Map.reject(%{a: 1, b: 2}, fn({_k, v}) -> is_nil(v) end) == %{a: 1, b: 2}
  end

  test "invert/1 inverts map" do
    assert Map.invert(%{a: 1, b: 2}) == %{1 => :a, 2 => :b}
  end

  test "invert/1 raises error on duplicate values" do
    assert_raise RuntimeError, fn -> Map.invert(%{foo: 1, bar: 1}) end
  end
end
