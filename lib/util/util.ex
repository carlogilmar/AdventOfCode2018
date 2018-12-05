defmodule AdventOfCode.Util do

  def read_file( file ) do
    base_path = File.cwd!
    {:ok, text} = File.read( "#{base_path}/priv/#{file}" )
    String.split( text, "\n")
  end

end
