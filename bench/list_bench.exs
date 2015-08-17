defmodule Crutches.ListBench do
  alias Crutches.List
  use Benchfella

  @list 1..2000 |> Enum.to_list

  bench "shorten/2 2000 by 1500" do
    List.shorten @list, 1500
  end

  bench "split/2 2000 on evens" do
    List.split @list, &(rem(&1, 2) == 0)
  end
end
