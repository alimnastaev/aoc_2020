defmodule AOC_2020.Day2 do
  def part_one() do
    Enum.count(parse_file(), &old_valid_password?/1)
  end

  def part_two() do
    Enum.count(parse_file(), &new_valid_password?/1)
  end

  defp old_valid_password?([low, high, letter, password]) do
    String.graphemes(password)
    |> Enum.count(&(&1 == letter))
    |> Kernel.in(low..high)
  end

  defp new_valid_password?([low, high, letter, password]) do
    low_match? = String.at(password, low - 1) == letter
    high_match? = String.at(password, high - 1) == letter

    !(low_match? && high_match?) && (low_match? || high_match?)
  end

  defp parse_file(input \\ "lib/day_2/input_file.txt") do
    File.read!(input)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&structure_data/1)
  end

  defp structure_data(item) do
    [policy, password] = split_string(item, ": ")
    [range, letter] = split_string(policy, " ")
    [low, high] = split_string(range, "-")

    [String.to_integer(low), String.to_integer(high), letter, password]
  end

  defp split_string(string, pattern) do
    String.split(string, pattern, parts: 2)
  end
end
