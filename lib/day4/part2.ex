defmodule Day4.Part2 do
  @doc """
      iex> Day4.Part2.part2("day4-sample.txt")
      4
  """
  def part2(filename) do
    parse_input(filename)
    |> Enum.filter(&pair_overlaps/1)
    |> Enum.count()
  end

  @doc """
      iex> Day4.Part2.part2
      857
  """
  def part2 do
    part2("day4.txt")
  end

  @doc """
      iex> Day4.Part2.pair_overlaps([[2,4], [6,8]])
      false
      iex> Day4.Part2.pair_overlaps([[2,8], [3,7]])
      true
      iex> Day4.Part2.pair_overlaps([[5,7], [7,9]])
      true
  """
  def pair_overlaps([[r1start, r1end], [r2start, r2end]]) do
    (r1start >= r2start && r1start <= r2end) ||
      (r2start >= r1start && r2start <= r1end)
  end

  def parse_input(filename) do
    "inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.map(fn s ->
      String.split(s, ",")
      |> Enum.map(fn range_str ->
        String.split(range_str, "-")
        |> Enum.map(&String.to_integer/1)
      end)
    end)
  end
end
