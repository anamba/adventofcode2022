defmodule Day2.Part1 do
  @doc """
      iex> Day2.Part1.part1("day2-sample.txt")
      15
  """
  def part1(filename) do
    parse_input(filename)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  @doc """
      iex> Day2.Part1.part1
      8933
  """
  def part1 do
    part1("day2.txt")
  end

  @doc """
      iex> Day2.Part1.calculate_score({"A","Y"})
      8
      iex> Day2.Part1.calculate_score({"B","X"})
      1
      iex> Day2.Part1.calculate_score({"C","Z"})
      6
  """
  def calculate_score({opp, me}) do
    shape_score(me) + outcome_score(opp, me)
  end

  def shape_score("X"), do: 1
  def shape_score("Y"), do: 2
  def shape_score("Z"), do: 3

  def outcome_score("A", "X"), do: 3
  def outcome_score("B", "Y"), do: 3
  def outcome_score("C", "Z"), do: 3
  def outcome_score("A", "Z"), do: 0
  def outcome_score("C", "X"), do: 6
  def outcome_score("C", "Y"), do: 0
  def outcome_score("B", "Z"), do: 6
  def outcome_score("B", "X"), do: 0
  def outcome_score("A", "Y"), do: 6

  @doc """
      iex> Day2.Part1.parse_input("day2-sample.txt")
      [{"A","Y"}, {"B","X"}, {"C","Z"}]
  """
  def parse_input(filename) do
    "inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.map(fn
      "A " <> me ->
        {"A", me}

      "B " <> me ->
        {"B", me}

      "C " <> me ->
        {"C", me}
    end)
  end
end
