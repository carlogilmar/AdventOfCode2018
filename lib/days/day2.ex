defmodule AdventOfCode.Day2 do
  alias AdventOfCode.Util

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
      _ -> raise "No condition for apply here!!!!!"
    end
  end

  def get_checksum( tags ) do
    twices = Enum.count( tags, fn tag -> tag == :twice end)
    threes = Enum.count( tags, fn tag -> tag == :three end)
    %{ twice: twices, three: threes }
  end

  def process( multiline ) do
    tags_in_multiline = for line <- multiline, do: validate_line( line )
    tags = tags_in_multiline |> List.flatten()
    %{ twice: twices, three: threes } = get_checksum( tags )
    IO.puts "Checksum :: (II) #{twices} * (III) #{threes} "
    twices * threes
  end

  def get_exercise_result() do
    "day2/day2.txt"
      |> Util.read_file()
      |> process()
  end

end
