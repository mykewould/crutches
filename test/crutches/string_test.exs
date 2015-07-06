defmodule Crutches.StringTest do
  alias Crutches.String
  use ExUnit.Case, async: true
  doctest Crutches.String

  def compare_underscored_camel(string_pairs) do
    string_pairs |> Enum.each fn([camel_case, underscore]) ->
      assert underscore == String.underscore(camel_case)
    end
  end

  # def basic_camel_underscore_pairs do
  #   [
  #     ["Product",               "product"],
  #     ["SpecialGuest",          "special_guest"],
  #     ["ApplicationController", "application_controller"],
  #     ["Area51Controller",      "area51_controller"]
  #   ]
  # end

  # Covered by doctests
  # test :camel_to_underscore do
  #   compare_underscored_camel(basic_camel_underscore_pairs)
  # end

  test :camel_to_underscore_without_reverse do
    [
      ["HTMLTidy",           "html_tidy"],
      ["HTMLTidyGenerator",  "html_tidy_generator"],
      ["FreeBSD",            "free_bsd"],
      ["HTML",               "html"],
      ["ForceXMLController", "force_xml_controller"]
    ]
    |> compare_underscored_camel
  end

  test :camel_with_module_to_underscore_with_slash do
    [
      ["Admin.Product",                    "admin/product"],
      ["Users.Commission.Department",      "users/commission/department"],
      ["UsersSection.CommissionDepartment","users_section/commission_department"]
    ]
    |> compare_underscored_camel
  end

  # Covered by doctests
  # test :underscore_to_camel do
  #   basic_camel_underscore_pairs |> Enum.each fn([camel_case, underscore]) ->
  #     assert camel_case == String.camelize(underscore)
  #   end
  # end

# Access
  # Covered by doctests
  # test :from_with_positive_integer do
  #   assert "lo" == String.from("hello", 3)
  # end
  #
  # test :from_with_negative_integer do
  #   assert "lo" == String.from("hello", -2)
  # end
  #
  # test :from_with_zero do
  #   assert "hello" == String.from("hello", 0)
  # end
end
