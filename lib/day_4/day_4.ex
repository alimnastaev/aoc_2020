defmodule AOC_2020.Day4 do
  @required ["byr", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]
  @with_optional ["byr", "cid", "ecl", "eyr", "hcl", "hgt", "iyr", "pid"]
  @eye_color ["amb", "blu", "brn", "gry", "grn", "hzl", "oth"]

  def part_one(),
    do:
      parse_file()
      |> Enum.count(&valid_keys?/1)

  def part_two(),
    do:
      parse_file()
      |> Enum.filter(&valid_keys?/1)
      |> Enum.count(&valid_values?/1)

  defp valid_keys?(map),
    do:
      Map.keys(map) ==
        @required || Map.keys(map) == @with_optional

  defp valid_values?(%{
         "byr" => byr,
         "cid" => cid,
         "ecl" => ecl,
         "eyr" => eyr,
         "hcl" => hcl,
         "hgt" => hgt,
         "iyr" => iyr,
         "pid" => pid
       }) do
    byr?(byr) &&
      iyr?(iyr) &&
      eyr?(eyr) &&
      hgt?(hgt) &&
      hcl?(hcl) &&
      ecl?(ecl) &&
      pid?(pid) &&
      cid?(cid)
  end

  defp valid_values?(%{
         "byr" => byr,
         "ecl" => ecl,
         "eyr" => eyr,
         "hcl" => hcl,
         "hgt" => hgt,
         "iyr" => iyr,
         "pid" => pid
       }) do
    byr?(byr) &&
      iyr?(iyr) &&
      eyr?(eyr) &&
      hgt?(hgt) &&
      hcl?(hcl) &&
      ecl?(ecl) &&
      pid?(pid)
  end

  defp byr?(byr), do: valid_range?(byr, 1920, 2002)

  defp iyr?(iyr), do: valid_range?(iyr, 2010, 2020)

  defp eyr?(eyr), do: valid_range?(eyr, 2020, 2030)

  defp hcl?(hcl), do: Regex.match?(~r/\A#[0-9a-f]{6}\z/, hcl)

  defp ecl?(ecl), do: ecl in @eye_color

  defp pid?(pid), do: Regex.match?(~r/\A\d{9}\z/, pid)

  defp hgt?(hgt) do
    [hgt, cm_or_in?] =
      Regex.run(~r/\A(\d+)([^\d]+)\z/, hgt, capture: :all_but_first)
      |> case do
        [hgt, cm_or_in?] -> [hgt, cm_or_in?]
        nil -> [0, nil]
      end

    case cm_or_in? do
      "cm" -> valid_range?(hgt, 150, 193)
      "in" -> valid_range?(hgt, 59, 76)
      nil -> false
    end
  end

  defp cid?(_), do: true

  defp valid_range?(string_integer, low, high),
    do:
      String.to_integer(string_integer)
      |> Kernel.in(low..high)

  defp parse_file(input \\ "lib/day_4/input_file.txt"),
    do:
      File.read!(input)
      |> String.split("\n\n")
      |> Enum.map(&String.split(&1, ~r/(\s)/))
      |> Enum.map(fn list -> Enum.map(list, fn x -> String.split(x, ":", parts: 2) end) end)
      |> Enum.map(fn x -> Enum.map(x, fn [a, b] -> {a, b} end) |> Map.new() end)

  def permutations([]), do: [[]]

  def permutations(list),
    do: for(elem <- list, rest <- permutations(list -- [elem]), do: [elem | rest])

  def result() do
    result =
      pop()
      |> Enum.filter(fn x ->
        if Enum.sum(x) == 7, do: IO.inspect(x)
      end)

    IO.inspect(result, label: "RESULT ? \n")
  end

  def pop() do
    for x <- [1, 2, 3, 4], y <- [1, 2, 3, 4], x != y, do: [x, y]
  end
end
