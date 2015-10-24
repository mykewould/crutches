defmodule Crutches.ListBench do
  alias Crutches.List
  use Benchfella

  @list 1..2000 |> Enum.to_list

  bench "from/2 from the head" do
    List.from @list, 0
  end

  bench "from/2 from the middle" do
    List.from @list, 987
  end

  bench "in_groups/2 without a filler value" do
    List.in_groups @list, 100
  end

  bench "in_groups/3 with a value" do
    List.in_groups @list, 100, 0
  end

  bench "in_groups/4 with a mapping function" do
    List.in_groups @list, 100, 0, fn(grp) -> grp end
  end

  bench "shorten/2 2000 by 1500" do
    List.shorten @list, 1500
  end

  bench "split/2 2000 on evens" do
    List.split @list, &(rem(&1, 2) == 0)
  end
end
