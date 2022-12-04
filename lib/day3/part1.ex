defmodule Day3.Part1 do
  @doc """
      iex> Day3.Part1.part1("day3-sample.txt")
      157
  """
  def part1(filename) do
    parse_input(filename)
    |> Enum.map(&find_common_item/1)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  @doc """
      iex> Day3.Part1.part1
      8053
  """
  def part1 do
    part1("day3.txt")
  end

  def find_common_item(list) do
    len = length(list)
    {set1, set2} = Enum.split(list, div(len, 2))
    {set1, set2} = {MapSet.new(set1), MapSet.new(set2)}

    MapSet.intersection(set1, set2)
    |> MapSet.to_list()
    |> List.first()
  end

  def calculate_score(item) when item in ?a..?z, do: item - ?a + 1
  def calculate_score(item) when item in ?A..?Z, do: item - ?A + 27

  def parse_input(filename) do
    "inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.map(&to_charlist/1)
  end
end
