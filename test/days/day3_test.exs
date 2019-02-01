defmodule AdventOfCodeTest.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Day3

  test "Get a matriz" do
    m = Day3.build_matriz( 4 )
    m_expected = [ [".",".",".","."],  [".",".",".","."],  [".",".",".","."],  [".",".",".","."] ]
    assert m == m_expected
  end

	test "Get the sizes from string line" do
		line1 = "#15 @ 823,32: 23x26"
		line2 = "#16 @ 124,118: 20x18"
		line3 = "#17 @ 675,632: 22x26"
		w_line1 = {823, 32, 23, 26}
		w_line2 = {124, 118, 20, 18}
		w_line3 = {675, 632, 22, 26}
		size_from_line1 = Day3.get_sizes( line1 )
		size_from_line2 = Day3.get_sizes( line2 )
		size_from_line3 = Day3.get_sizes( line3 )
		assert size_from_line1 == w_line1
		assert size_from_line2 == w_line2
		assert size_from_line3 == w_line3
	end

	test "Draw a rectangle in matrix" do
		rectangle = "#123 @ 3,2: 5x4"
		new_matriz = Day3.build_matriz( 11 ) |> Day3.draw_rectangle_in_matriz( rectangle )
		m_expected =
			[
			  [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
			  [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
			  [".", ".", ".", "#", "#", "#", "#", "#", ".", ".", "."],
			  [".", ".", ".", "#", "#", "#", "#", "#", ".", ".", "."],
			  [".", ".", ".", "#", "#", "#", "#", "#", ".", ".", "."],
			  [".", ".", ".", "#", "#", "#", "#", "#", ".", ".", "."],
			  [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
			  [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
			  [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
			  [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."],
			  [".", ".", ".", ".", ".", ".", ".", ".", ".", ".", "."]
			]
		assert new_matriz == m_expected
	end

end
