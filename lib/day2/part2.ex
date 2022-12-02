defmodule Day2.Part2 do
  @doc """
      iex> Day2.Part2.part2("day2-sample.txt")
      12
  """
  def part2(filename) do
    parse_input(filename)
    |> Enum.map(&calculate_score/1)
    |> Enum.sum()
  end

  @doc """
      iex> Day2.Part2.part2
      11998
  """
  def part2 do
    part2("day2.txt")
  end

  @doc """
      iex> Day2.Part2.calculate_score({"A","Y"})
      4
      iex> Day2.Part2.calculate_score({"B","X"})
      1
      iex> Day2.Part2.calculate_score({"C","Z"})
      7
  """
  def calculate_score({opp, outcome}) do
    shape_score(required_shape(opp, outcome)) + outcome_score(opp, outcome)
  end

  def shape_score("R"), do: 1
  def shape_score("P"), do: 2
  def shape_score("S"), do: 3

  def outcome_score(_, "X"), do: 0
  def outcome_score(_, "Y"), do: 3
  def outcome_score(_, "Z"), do: 6

  def required_shape("A", "X"), do: "S"
  def required_shape("B", "X"), do: "R"
  def required_shape("C", "X"), do: "P"
  def required_shape("A", "Y"), do: "R"
  def required_shape("B", "Y"), do: "P"
  def required_shape("C", "Y"), do: "S"
  def required_shape("A", "Z"), do: "P"
  def required_shape("B", "Z"), do: "S"
  def required_shape("C", "Z"), do: "R"

  @doc """
      iex> Day2.Part2.parse_input("day2-sample.txt")
      [{"A","Y"}, {"B","X"}, {"C","Z"}]
  """
  def parse_input(filename) do
    "inputs/#{filename}"
    |> File.stream!()
    |> Stream.map(&String.trim/1)
    |> Enum.map(fn
      "A " <> outcome ->
        {"A", outcome}

      "B " <> outcome ->
        {"B", outcome}

      "C " <> outcome ->
        {"C", outcome}
    end)
  end
end
