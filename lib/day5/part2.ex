defmodule Day5.Part2 do
  @doc """
      iex> Day5.Part2.part2("day5-sample.txt")
      "MCD"
  """
  def part2(filename) do
    {stacks, instructions} = parse_input(filename)
    stacks = process_instructions(stacks, instructions)

    stacks
    |> Map.values()
    |> Enum.map(&(List.first(&1) || " "))
    |> Enum.filter(& &1)
    |> to_string()
  end

  @doc """
      iex> Day5.Part2.part2
      "LLWJRBHVZ"
  """
  def part2 do
    part2("day5.txt")
  end

  def process_instructions(stacks, []), do: stacks

  def process_instructions(stacks, [{count, from, to} | instructions]) do
    stacks = process_instruction(stacks, count, from, to)

    process_instructions(stacks, instructions)
  end

  def process_instruction(stacks, 0, _from, _to), do: stacks

  def process_instruction(stacks, count, from, to) when count > 0 do
    crates = stacks[from] |> Enum.take(count)

    stacks
    |> Map.put(from, stacks[from] |> Enum.drop(count))
    |> Map.put(to, crates ++ stacks[to])
  end

  def parse_input(filename) do
    {stacks, instructions} =
      "inputs/#{filename}"
      |> File.stream!()
      |> Stream.map(&String.trim_trailing/1)
      |> Enum.split_while(&(String.length(&1) > 0))

    {parse_stacks(stacks |> Enum.reverse() |> Enum.drop(1)), parse_instructions(instructions)}
  end

  @doc """
      iex> Day5.Part2.parse_stacks(["[Z] [M] [P]", "[N] [C]    ", "    [D]    "])
      %{1 => [?N, ?Z], 2 => [?D, ?C, ?M], 3 => [?P]}
  """
  def parse_stacks(list), do: parse_stacks(list, %{})
  def parse_stacks([], output), do: output

  def parse_stacks([first | rest], output) do
    crates_to_add =
      first
      |> String.to_charlist()
      |> Enum.chunk_every(4)
      |> Enum.map(&Enum.at(&1, 1))
      |> Enum.with_index(1)

    output =
      Enum.reduce(crates_to_add, output, fn {crate, index}, acc ->
        case crate do
          32 -> acc
          other -> Map.put(acc, index, [other | acc[index] || []])
        end
      end)

    parse_stacks(rest, output)
  end

  @doc """
      iex> Day5.Part2.parse_instructions(["move 1 from 2 to 1", "move 3 from 1 to 3"])
      [{1,2,1}, {3,1,3}]
  """
  def parse_instructions(list), do: parse_instructions(list, [])
  def parse_instructions([], output), do: Enum.reverse(output)

  def parse_instructions(["" | rest], output), do: parse_instructions(rest, output)

  def parse_instructions([first | rest], output) do
    [_, count, _, from, _, to] = String.split(first)

    parse_instructions(rest, [
      {String.to_integer(count), String.to_integer(from), String.to_integer(to)} | output
    ])
  end
end
