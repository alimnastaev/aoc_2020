defmodule AOC_2020.Day1 do
  @target 2020
  def part_one() do
    result =
      try do
        for x <- list_of_numbers(),
            y <- list_of_numbers(),
            x + y == @target,
            do: throw({:break, x * y})
      catch
        {:break, result} -> result
      end

    IO.puts("PART ONE result is: \n#{result}")
  end

  def part_two() do
    result =
    try do
      for x <- list_of_numbers(),
          y <- list_of_numbers(),
          z <- list_of_numbers(),
          x + y + z == @target,
          do: throw({:break, x * y * z})
    catch
      {:break, result} -> result
    end
    IO.puts("PART TWO result is: \n#{result}")
  end

  defp list_of_numbers(input \\ "day_1/input_file.txt") do
    File.read!(input)
    |> String.trim()
    |> String.split("\n")
    |> Enum.map(&String.to_integer/1)
  end
end

AOC_2020.Day1.part_one()
AOC_2020.Day1.part_two()
