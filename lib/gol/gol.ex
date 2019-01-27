defmodule GameOfLife do

  def fake_population() do
    [
      [:c1,  :c2,  :c3,  :c4],
      [:c5,  :c6,  :c7,  :c8],
      [:c9,  :c10, :c11, :c12],
      [:c13, :c14, :c15, :c16]
    ]
  end

  def get_neighbors( population, {x,y} ) do
    up_neighbors = population |> get_up_neighbors(x,y)
    middle_neighbors = population |> get_middle_neighbors(x,y)
    down_neighbors = population |> get_down_neighbors(x,y)
    up_neighbors ++ middle_neighbors ++ down_neighbors
  end

  def get_up_neighbors( population, x, y ) do
    row = Enum.at( population, y-1 )
    case Enum.at( row, x+1 ) do
      nil ->
        [h|_t] = row
        [ Enum.at( row, x-1 ), Enum.at( row, x ), h ]
      _ -> [ Enum.at( row, x-1 ), Enum.at( row, x ), Enum.at( row, x+1 ) ]
    end
  end

  def get_middle_neighbors( population, x, y ) do
    row = Enum.at( population, y )
    case Enum.at( row, x+1 ) do
      nil ->
        [h|_t] = row
        [ Enum.at( row, x-1 ), h ]
      _ ->
        [ Enum.at( row, x-1 ), Enum.at( row, x+1 ) ]
    end
  end

  def get_down_neighbors( population, x, y ) do
    row = Enum.at( population, y+1 )
    case row do
      nil ->
        row = Enum.at( population, 0 )
        find_down_neighbors_2( row, x )
      _ ->
        find_down_neighbors( row, x )
    end
  end

  def find_down_neighbors_2( row, x ) do
    [h|_t] = row
    case (Enum.at( row, x ) == h) do
      true ->
        [ Enum.at( row, x-1 ), Enum.at( row, x ), Enum.at( row, x+1 )]
      false ->
        [ Enum.at( row, x-1 ), Enum.at( row, x ), h ]
    end
  end

  def find_down_neighbors( row, x ) do
    case Enum.at( row, x+1 ) do
      nil ->
        [h|_t] = row
        [ Enum.at( row, x-1 ), Enum.at( row, x ), h ]
      _ ->
        [ Enum.at( row, x-1 ), Enum.at( row, x ), Enum.at( row, x+1 ) ]
    end
  end

end
