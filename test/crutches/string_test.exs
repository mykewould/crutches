defmodule Crutches.StringTest do
  alias Crutches.String
  use ExUnit.Case

  def compare_underscored_camel string_pairs do
    Enum.each string_pairs fn [camel_case, underscore] ->
      assert underscore == String.underscore camel_case
    end
  end

  test :camel_to_underscore do
    [
      ["Product",               "product"],
      ["SpecialGuest",          "special_guest"],
      ["ApplicationController", "application_controller"],
      ["Area51Controller",      "area51_controller"]
    ]
    |> compare_underscored_camel
  end

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
end
