defmodule AdventOfCode.Day3 do
  alias AdventOfCode.Util

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
		[xy_parsed, _] = xy |> String.split(":")
		[x, y] = xy_parsed |> String.split(",")
		{ String.to_integer(x), String.to_integer(y), String.to_integer(w), String.to_integer(h)}
	end

	def draw_rectangle_in_matriz( matriz, rectangle ) do
		{x,y,w,h} = get_sizes( rectangle )
		max_index = length(matriz)
		claim_rows = Enum.slice( matriz, y, h )
		up_rows = Enum.slice( matriz, 0, y )
		down_rows = Enum.slice( matriz, (y+h), (max_index-y-h))
		new_claim_rows = redraw_claim_rows( {claim_rows, x, w} )
		up_rows ++ new_claim_rows ++ down_rows
	end

	def redraw_claim_rows( {claim_rows, x, w} ) do
		for row <- claim_rows do
			redraw2( {row, x, w, 0, 0 >= x, 0 < x+w }, [] )
		end
	end

	def set_inch( "#" ), do: "x"
	def set_inch( "x" ), do: "x"
	def set_inch( "." ), do: "#"

	def redraw2( {row, x, w, index, true, true}, new_row ) do
		[h|row_tail] = row
		next_inch = set_inch( h )
		n_row = new_row ++ [next_inch]
		case row_tail do
			[] -> n_row
			_ -> redraw2( {row_tail, x, w, index+1, index+1 >= x, index+1 < x+w }, n_row )
		end
	end

	def redraw2( {row, x, w, index, _, _}, new_row ) do
		[h|row_tail] = row
		n_row = new_row ++ [h]
		case row_tail do
			[] -> n_row
			_ -> redraw2( {row_tail, x, w, index+1, index+1 >= x, index+1 < x+w }, n_row )
		end
	end

	def drawing_matriz( matriz_init_size, rectangles ) do
		matriz = build_matriz( matriz_init_size )
		IO.puts "Matrix generated..."
		redraw_rectangles( matriz, rectangles, 0)
	end

	def redraw_rectangles( matriz, [""], _index), do: matriz
	def redraw_rectangles( matriz, rectangles, index ) do
		IO.puts "Process... #{index}"
		[rectangle|rectangles_tail] = rectangles
		new_matriz = draw_rectangle_in_matriz( matriz, rectangle )
		redraw_rectangles( new_matriz, rectangles_tail, index+1 )
	end

  def get_exercise_result() do
    rectangles = "day3/day3.txt" |> Util.read_file()
		matriz = drawing_matriz( 1000, rectangles )
		count_inches( matriz )
  end

	def count_inches( matriz ) do
		counters =
		for row <- matriz do
			Enum.count( row, fn e -> e == "x" end)
		end
		final_sum = Enum.sum( counters )
		{ :final_sum, final_sum }
	end
end
