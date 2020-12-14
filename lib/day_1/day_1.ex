defmodule AOC_2020.Day1 do
  def part_one() do
    {a, b} =
      list_of_numbers()
      |> result_one()

    a * b
  end

  def part_two() do
    {a, b, c} =
      list_of_numbers()
      |> result_two()

    a * b * c
  end

  defp result_one(list, target \\ 2020) do
    Enum.reduce_while(list, nil, fn first_number, _acc ->
      second_number = target - first_number

      Enum.find(list, fn x -> x == second_number end)
      |> case do
        nil -> {:cont, nil}
        x -> {:halt, {first_number, x}}
      end
    end)
  end

  defp result_two(list, target \\ 2020) do
    try do
      for a <- list,
          b <- list,
          c <- list,
          a + b + c == target,
          do: throw({:break, {a, b, c}})
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
