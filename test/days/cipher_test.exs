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
    matriz = Cipher.create_matriz()
    assert length( matriz ) == 26
  end

  test "Find a letter in the matriz" do
    letter_in_matriz1 = Cipher.find_coordinate( {"e","b"} )
    letter_in_matriz2 = Cipher.find_coordinate( {"x","d"} )
    letter_in_matriz3 = Cipher.find_coordinate( {"d","p"} )
    assert letter_in_matriz1 == "f"
    assert letter_in_matriz2 == "a"
    assert letter_in_matriz3 == "s"
  end

end
