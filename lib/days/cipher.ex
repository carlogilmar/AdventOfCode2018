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
    row = Enum.find( matriz, fn [x|_y] -> <<x>> == "#{coor_y}"  end)
    <<binary_coor::8>> = coor_x
    size = ?a..binary_coor |> Enum.to_list |> length
    letter = Enum.at( row, size-1)
    <<letter>>
  end

end
