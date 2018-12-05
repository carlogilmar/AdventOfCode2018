defmodule AdventOfCode.Day1 do
  alias AdventOfCode.Util

  def get_exercise_result( path ) do
    Util.read_file( path )
    |> get_numbers
    |> get_sum
  end

  def get_integer( "" ), do: 0
  def get_integer( string ), do: string |> String.to_integer

  def get_numbers( list ) do
    for e <- list do
      get_integer( e )
    end
  end

  def get_sum( numbers ) do
    Enum.sum( numbers )
  end
end
