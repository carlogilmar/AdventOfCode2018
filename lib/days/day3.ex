defmodule AdventOfCode.Day3 do

  def build_matriz( size ), do: fill_matriz( size, 0, false, [] )

  def fill_matriz( _size, _index, true, matriz ), do: matriz
  def fill_matriz( size, index, false, matriz ) do
    row = String.duplicate(".", size) |> String.codepoints
    new_matriz = matriz ++ [row]
    fill_matriz( size, index+1, size==index+1, new_matriz)
  end

	def get_sizes( rectangle ) do
    [_id, _at, xy, wh] = rectangle |> String.split(" ")
		[w, h] = wh |> String.split("x")
		[xy_parsed, _] = xy |> String.split ":"
		[x, y] = xy_parsed |> String.split(",")
		{ String.to_integer(x), String.to_integer(y), String.to_integer(w), String.to_integer(h)}
	end

	def draw_rectangle_in_matriz( matriz, rectangle ) do
		{x,y,w,h} = get_sizes( rectangle )
		max_index = length(matriz)
		claim_rows = Enum.slice( matriz, y+1, h )
		up_rows = Enum.slice( matriz, 0, y )
		down_rows = Enum.slice( matriz, (y+h), (max_index-y-h))
		new_claim_rows = redraw_claim_rows( {claim_rows, x, w} )
		up_rows ++ new_claim_rows ++ down_rows
	end

	def redraw_claim_rows( {claim_rows, x, w} ) do
		for row <- claim_rows, do: redraw( row, x, w )
	end

	def redraw(row, x, w) do
		size = length(row)
		spaces_left = String.duplicate(".", x) |> String.codepoints
		drawing = String.duplicate("#", w) |> String.codepoints
		spaces_rigth = String.duplicate(".", (size-x-w)) |> String.codepoints
		new_row = [spaces_left] ++ [drawing] ++ [spaces_rigth]
		new_row |> List.flatten
	end

end
