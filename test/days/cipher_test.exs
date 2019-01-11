defmodule AdventOfCodeTest.CipherTest do
  use ExUnit.Case
alias AdventOfCode.Cipher

  test "Build the first alphabet" do
    alphabet = Cipher.generate_alphabet
    assert 'abcdefghijklmnopqrstuvwxyz' == alphabet
  end

  test "Modify the alphabet list" do
    alphabet = Cipher.generate_alphabet
    modified = Cipher.alter_alphabet( alphabet )
    assert 'bcdefghijklmnopqrstuvwxyza' == modified
  end

  test "Generate the alphabet matriz" do
    row1 = 'abcdefghijklmnopqrstuvwxyz'
    letter1 = 'a'
    row2 = 'bcdefghijklmnopqrstuvwxyza'
    letter2 = 'b'
    row1_m = Cipher.generate_row( letter1, row1 )
    row2_m = Cipher.generate_row( letter2, row2 )
    assert row1_m == 'bcdefghijklmnopqrstuvwxyza'
    assert row2_m == 'cdefghijklmnopqrstuvwxyzab'
  end

end
