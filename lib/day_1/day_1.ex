defmodule AOC_2020.Day1 do
  @target 2020
  def part_one() do
    try do
      for x <- list_of_numbers(),
          y <- list_of_numbers(),
          x + y == @target,
          do: throw({:break, x * y})
    catch
      {:break, result} -> result
    end
  end

  def part_two() do
    try do
      for x <- list_of_numbers(),
          y <- list_of_numbers(),
          z <- list_of_numbers(),
          x + y + z == @target,
          do: throw({:break, x * y * z})
    catch
      {:break, result} -> result
    end
  end

  defp list_of_numbers(input \\ "lib/day_1/input_file.txt") do
    File.read!(input)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end
