defmodule AOC_2020.Day5 do
  def part_one() do
  end

  def part_two() do
  end

  defp parse_file(input \\ "lib/day_5/input_file.txt"),
    do:
      File.read!(input)
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, ~r/(\s)/))
      |> Enum.map(fn list -> Enum.map(list, fn x -> String.split(x, ":", parts: 2) end) end)
      |> Enum.map(fn x -> Enum.map(x, fn [a, b] -> {a, b} end) |> Map.new() end)
end
