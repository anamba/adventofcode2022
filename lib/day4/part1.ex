defmodule Day4.Part1 do
  @doc """
      iex> Day4.Part1.part1("day4-sample.txt")
      2
  """
  def part1(filename) do
    parse_input(filename)
    |> Enum.filter(&pair_contains_superset/1)
    |> Enum.count()
  end

  @doc """
      iex> Day4.Part1.part1
      485
  """
  def part1 do
    part1("day4.txt")
  end

  @doc """
      iex> Day4.Part1.pair_contains_superset([[2,4], [6,8]])
      false
      iex> Day4.Part1.pair_contains_superset([[2,8], [3,7]])
      true
  """
  def pair_contains_superset([[r1start, r1end], [r2start, r2end]]) do
    (r1start <= r2start && r1end >= r2end) ||
      (r2start <= r1start && r2end >= r1end)
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
