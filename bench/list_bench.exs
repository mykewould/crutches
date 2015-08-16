defmodule Crutches.ListBench do
  use Benchfella

  @list 1..2000 |> Enum.to_list

  bench "shorten/2" do
    Crutches.List.shorten @list, 1500
  end
end
