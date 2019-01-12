defmodule AdventOfCode.Cipher do

  def generate_alphabet(), do: ?a..?z |> Enum.to_list
  def alter_alphabet( [init|sentence] ), do: sentence ++ [init]

  def generate_matriz( matriz, abc ) when abc == 'zabcdefghijklmnopqrstuvwxy', do: matriz ++ [abc]

  def generate_matriz( matriz, abc ) do
    matriz = matriz ++ [abc]
    new_alp = alter_alphabet( abc )
    generate_matriz( matriz, new_alp )
  end

  def create_matriz( ) do
    abc = generate_alphabet()
    generate_matriz( [], abc )
  end

  def find_coordinate( {coor_x, coor_y} ) do
    matriz = create_matriz()
    row = Enum.find( matriz, fn [x|_y] -> <<x>> == "#{coor_x}"  end)
    <<binary_coor::8>> = coor_y
    size = ?a..binary_coor |> Enum.to_list |> length
    letter = Enum.at( row, size-1)
    <<letter>>
  end

  def get_coordinates( key_word, sentence ) do
    sentence_letters = sentence |> String.replace(" ", "") |> String.codepoints
    size = length( sentence_letters )
    key_word_filled = fill( key_word, size )
    Enum.zip( key_word_filled, sentence_letters )
  end

  def fill( word, size ) do
    letters = word |> String.codepoints
    letters_size = length( letters )
    times = rem( size, letters_size )
    sentence_filled = String.duplicate( word, times+2 ) |> String.codepoints
    add_letters( {letters, size, sentence_filled, letters_size == size} )
  end

  def add_letters( {letters, _size, _sentence_filled, true} ), do: letters
  def add_letters( {letters, size, sentence_filled, false} ) do
    [letter|tail_sentence_filled] = sentence_filled
    letters_filled = letters ++ [letter]
    new_sentence_filled = length( letters_filled )
    add_letters { letters_filled, size, tail_sentence_filled, new_sentence_filled==size }
  end

end
