defmodule Day1.Part2 do
  @doc """
      iex> Day1.Part2.part2("day1-sample.txt")
      45000
  """
  def part2(filename) do
    parse_input(filename)
    |> Enum.sort_by(&(-&1))
    |> Enum.take(3)
    |> Enum.sum()
  end

  @doc """
      iex> Day1.Part2.part2
      199357
  """
  def part2 do
    part2("day1.txt")
  end

  @doc """
      iex> Day1.Part2.parse_input("day1-sample.txt")
      [6000, 4000, 11000, 24000, 10000]
  """
  def parse_input(filename) do
    "inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(&(Enum.map(&1, fn s -> String.to_integer(s) end) |> Enum.sum()))
  end
end
