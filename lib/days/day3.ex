defmodule AdventOfCode.Day3 do

  def build_matriz( size ), do: fill_matriz( size, 0, false, [] )

  def fill_matriz( _size, _index, true, matriz ), do: matriz
  def fill_matriz( size, index, false, matriz ) do
    row = String.duplicate(".", size) |> String.codepoints
    new_matriz = matriz ++ [row]
    fill_matriz( size, index+1, size==index+1, new_matriz)
  end

	def draw_rectangle_in_matriz( matriz, rectangle ) do
		{x,y,w,h} = get_sizes( rectangle )
	end

	def get_sizes( rectangle ) do
    [_id, _at, xy, wh] = rectangle |> String.split(" ")
		[w, h] = wh |> String.split("x")
		[xy_parsed, _] = xy |> String.split ":"
		[x, y] = xy_parsed |> String.split(",")
		{ String.to_integer(x), String.to_integer(y), String.to_integer(w), String.to_integer(h)}
	end

end
