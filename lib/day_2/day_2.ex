defmodule AOC_2020.Day2 do
  def part_one() do
    Enum.reduce(parse_file(), 0, fn x, acc ->
      if old_valid_password?(x), do: acc + 1, else: acc
    end)
  end

  defp old_valid_password?([min, max, letter, password]) do
    String.graphemes(password)
    |> Enum.count(&(&1 == letter))
    |> Kernel.in(min..max)
  end

  defp parse_file(input \\ "lib/day_2/input_file.txt") do
    File.read!(input)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&structure_data/1)
  end

  defp structure_data(item) do
    [policy, password] = String.split(item, ": ", parts: 2)
    [range, letter] = String.split(policy, " ", parts: 2)
    [low, high] = String.split(range, "-", parts: 2)

    [String.to_integer(low), String.to_integer(high), letter, password]
  end
end
