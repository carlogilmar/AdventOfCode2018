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

end
