defmodule AdventOfCodeTest.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Day3

  test "Get a matriz" do
    m = Day3.build_matriz( 4 )
    m_expected = [ [".",".",".","."],  [".",".",".","."],  [".",".",".","."],  [".",".",".","."] ]
    assert m == m_expected
  end

end
