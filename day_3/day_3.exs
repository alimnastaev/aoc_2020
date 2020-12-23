defmodule AOC_2020.Day3 do
  def part_one() do
    result = slope_type(3, 1)

    IO.puts("PART ONE result is: \n#{result}")
  end

  def part_two() do
    result =
      slope_type(3, 1) * slope_type(1, 1) * slope_type(5, 1) * slope_type(7, 1) *
        slope_type(1, 2)

    IO.puts("PART TWO result is: \n#{result}")
  end

  def slope_type(right_move, down_move) do
    case down_move do
      1 ->
        count_result(parse_file(), right_move)

      2 ->
        Enum.take_every(parse_file(), down_move)
        |> count_result(right_move)
    end
  end

  def count_result(list, right_move) do
    [_index, result] =
      list
      |> Enum.reduce([0, 0], fn row, [index, trees] ->
        result =
          Stream.cycle(row)
          |> Enum.at(index)
          |> case do
            "#" -> trees + 1
            _ -> trees
          end

        [index + right_move, result]
      end)

    result
  end

  def parse_file(input \\ "day_3/input_file.txt"),
    do:
      File.read!(input)
      |> String.trim()
      |> String.split("\n")
      |> Enum.map(&String.graphemes/1)
end

AOC_2020.Day3.part_one()
AOC_2020.Day3.part_two()
