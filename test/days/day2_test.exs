defmodule AdventOfCodeTest.Day1Test do
  use ExUnit.Case
  alias AdventOfCode.Day2

  @string1 "abcdef"
  @string2 "bababc"
  @string3 "abbcde"
  @string4 "abcccd"
  @string5 "aabcdd"
  @string6 "abcdee"
  @string7 "ababab"

  test "Get the counters" do
    counters_s1 = Day2.validate_line( @string1 )
    counters_s2 = Day2.validate_line( @string2 )
    counters_s3 = Day2.validate_line( @string3 )
    counters_s4 = Day2.validate_line( @string4 )
    counters_s5 = Day2.validate_line( @string5 )
    counters_s6 = Day2.validate_line( @string6 )
    counters_s7 = Day2.validate_line( @string7 )
    assert counters_s1 == []
    assert counters_s2 == [:twice, :three]
    assert counters_s3 == [:twice]
    assert counters_s4 == [:three]
    assert counters_s5 == [:twice]
    assert counters_s6 == [:twice]
    assert counters_s7 == [:three]
  end

end
