defmodule AdventOfCodeTest.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Day1
  alias AdventOfCode.Util

  test "Reading a file with the needed text" do
    path = "day1/test1.txt"
    text = Util.read_file( path )
    [h|_] = text
    assert h == "-2"
  end

  test "parsing a string in integer" do
    s = "-23"
    s_integer = Day1.get_integer( s )
    assert s_integer == -23
  end

  test "parsins a list of integers" do
    list = [ "-12", "12", "10", ""]
    [a,b,c,_] = Day1.get_numbers( list )
    assert a == -12
    assert b == 12
    assert c == 10
  end

  test " Get the sum of a list of numbers" do
    list = [ 12, 10, 22, 10, 15, -10, -15]
    sum = Day1.get_sum( list )
    assert sum == 44
  end

  test "Get the sum from a file" do
    path = "day1/test1.txt"
    sum = Day1.get_exercise_result( path )
    assert sum == 0
  end
end
