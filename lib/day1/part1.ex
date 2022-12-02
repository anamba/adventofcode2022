defmodule Day1.Part1 do
  @doc """
      iex> Day1.Part1.part1("day1-sample.txt")
      24000
  """
  def part1(filename) do
    {_idx, amt} = find_largest_sum(parse_input(filename))
    amt
  end

  @doc """
      iex> Day1.Part1.part1
      67450
  """
  def part1 do
    part1("day1.txt")
  end

  @doc """
      iex> Day1.Part1.find_largest_sum([[1,2], [3], [4,5]])
      {2, 9}
  """
  def find_largest_sum([first | rest]), do: find_largest_sum(rest, {0, Enum.sum(first)}, 1)

  def find_largest_sum([], {top_idx, top_amt}, _idx), do: {top_idx, top_amt}

  def find_largest_sum([first | rest], {top_idx, top_amt}, idx) do
    amt = Enum.sum(first)

    if amt > top_amt do
      find_largest_sum(rest, {idx, amt}, idx + 1)
    else
      find_largest_sum(rest, {top_idx, top_amt}, idx + 1)
    end
  end

  @doc """
      iex> Day1.Part1.parse_input("day1-sample.txt")
      [[1000,2000,3000], [4000], [5000,6000], [7000,8000,9000], [10000]]
  """
  def parse_input(filename) do
    "inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.chunk_by(&(&1 == ""))
    |> Enum.filter(&(&1 != [""]))
    |> Enum.map(&Enum.map(&1, fn s -> String.to_integer(s) end))
  end
end
