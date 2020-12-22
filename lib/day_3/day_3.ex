defmodule AOC_2020.Day3 do
  def part_one() do
    [_index, result] =
      parse_file()
      |> Enum.reduce([0, 0], fn row, [index, trees] ->
        result =
          Stream.cycle(row)
          |> Enum.at(index)
          |> case do
            "#" -> trees + 1
            _ -> trees
          end

        [index + 3, result]
      end)

    result
  end

  def parse_file(input \\ "lib/day_3/input_file.txt") do
    File.read!(input)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.graphemes/1)
  end
end
