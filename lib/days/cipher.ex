defmodule AdventOfCode.Cipher do

  def generate_alphabet(), do: ?a..?z |> Enum.to_list
  def alter_alphabet( [init|sentence] ), do: sentence ++ [init]

  def generate_matriz( matriz, [init|sentence] ) when init == 'z', do: matriz = matriz ++ [init|sentence]

  def generate_matriz( matriz, abc ) do
    matriz = matriz ++ [abc]
    new_alp = alter_alphabet( abc )
    generate_matriz( matriz, new_alp )
  end

  def create_matriz( ) do
    abc = generate_alphabet()
    m = generate_matriz( [], abc )
  end

end
