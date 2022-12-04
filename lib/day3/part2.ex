defmodule Day3.Part2 do
  @doc """
      iex> Day3.Part2.part2("day3-sample.txt")
      70
  """
  def part2(filename) do
    parse_input(filename)
    |> Enum.map(&find_common_item/1)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  @doc """
      iex> Day3.Part2.part2
      2425
  """
  def part2 do
    part2("day3.txt")
  end

  def find_common_item([e1, e2, e3]) do
    {set1, set2, set3} = {MapSet.new(e1), MapSet.new(e2), MapSet.new(e3)}

    MapSet.intersection(set1, set2)
    |> MapSet.intersection(set3)
    |> MapSet.to_list()
    |> List.first()
  end

  def calculate_score(item) when item in ?a..?z, do: item - ?a + 1
  def calculate_score(item) when item in ?A..?Z, do: item - ?A + 27

  def parse_input(filename) do
    "inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Stream.map(&to_charlist/1)
    |> Enum.chunk_every(3)
  end
end
