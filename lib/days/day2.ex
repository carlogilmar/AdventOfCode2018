defmodule AdventOfCode.Day2 do

  def validate_line( line ) do
    line
      |> generate_counters()
      |> apply_rules()
  end

  def generate_counters( letters ) do
    letters_for_count = letters |> String.codepoints |> Enum.uniq
    total_letters = letters |> String.codepoints
    for letter <- letters_for_count do
      counter = Enum.count(total_letters, fn l -> l == letter end)
      {letter, counter}
    end
  end

  def apply_rules( counters ) do
    twices = Enum.count( counters, fn {_letter, size} -> size == 2 end)
    threes = Enum.count( counters, fn {_letter, size} -> size == 3 end)
    case {twices, threes} do
      {1,1} -> [:twice, :three]
      _ -> apply_second_rule( {twices, threes} )
    end
  end

  def apply_second_rule( {twices, threes} ) do
    case { twices>0, threes>0 } do
      {true, false} -> [:twice]
      {false, true} -> [:three]
      {false, false} -> []
      _ -> raise "No condition used!!!"
    end
  end

end
