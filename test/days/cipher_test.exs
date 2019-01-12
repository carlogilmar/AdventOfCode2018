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
    letter_in_matriz1 = Cipher.find_coordinate( {"b","e"} )
    letter_in_matriz2 = Cipher.find_coordinate( {"d","x"} )
    letter_in_matriz3 = Cipher.find_coordinate( {"p","d"} )
    assert letter_in_matriz1 == "f"
    assert letter_in_matriz2 == "a"
    assert letter_in_matriz3 == "s"
  end

  test "Fill a word with n letters" do
    size = 28
    word = "vigilance"
    word_filled = Cipher.fill( word, size )
    res = ["v", "i", "g", "i", "l", "a", "n", "c", "e", "v", "i", "g", "i", "l",
       "a", "n", "c", "e", "v", "i", "g", "i", "l", "a", "n", "c", "e", "v"]
    assert res == word_filled
  end

  test "Create coordinates for cipher" do
    key_word = "vigilance"
    sentence = "meet me on Tuesday evening at seven"
    coordinates = Cipher.get_coordinates( key_word, sentence )
    assert length( coordinates ) == 29
  end

end
