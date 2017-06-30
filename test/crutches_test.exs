defmodule CrutchesTest do
  use ExUnit.Case, async: true
  doctest Crutches

  describe "blank?" do
    test "is true for empty list" do
      assert Crutches.blank?([])
    end

    test "is false for list with one element" do
      refute Crutches.blank?([1])
    end

    test "is true for empty string" do
      assert Crutches.blank?("")
    end

    test "is true for string with only whitespace" do
      assert Crutches.blank?("\n  \n\u00A0")
    end

    test "is false for string with non-whitespace" do
      refute Crutches.blank?("\nh   ")
    end

    test "is true for empty charlist" do
      assert Crutches.blank?('')
    end

    test "is false for non-empty charlist" do
      refute Crutches.blank?('a')
    end

    test "is true for empty tuple" do
      assert Crutches.blank?({})
    end

    test "is false for non-empty tuple" do
      refute Crutches.blank?({:a, :b})
    end

    test "is true for empty map" do
      assert Crutches.blank?(%{})
    end

    test "is false for non-empty map" do
      refute Crutches.blank?(%{a: 1})
    end

    test "is true for false" do
      assert Crutches.blank?(false)
    end

    test "is true for nil" do
      assert Crutches.blank?(nil)
    end

    test "is false for integer" do
      refute Crutches.blank?(42)
    end

    test "is false for float" do
      refute Crutches.blank?(3.14)
    end

    test "is false for function" do
      refute Crutches.blank?(fn x -> x end)
    end

    test "is false for atom" do
      refute Crutches.blank?(:foo)
    end
  end
end
