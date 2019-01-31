defmodule AdventOfCode.Day3 do

  def build_matriz( size ), do: fill_matriz( size, 0, false, [] )

  def fill_matriz( _size, _index, true, matriz ), do: matriz
  def fill_matriz( size, index, false, matriz ) do
    row = String.duplicate(".", size) |> String.codepoints
    new_matriz = matriz ++ [row]
    fill_matriz( size, index+1, size==index+1, new_matriz)
  end

end
