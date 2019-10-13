defmodule GameOfLife do

  def fake_population() do
    [
      [:c1,  :c2,  :c3,  :c4],
      [:c5,  :c6,  :c7,  :c8],
      [:c9,  :c10, :c11, :c12],
      [:c13, :c14, :c15, :c16]
    ]
  end

  def fake_population2() do
    [
      [0,1,0,1],
      [0,0,1,0],
      [0,1,0,0],
      [0,0,0,0]
    ]
  end

  def fake_population3() do
    [
      [0,1,0,1],
      [1,1,0,0],
      [1,0,1,1],
      [0,0,0,1]
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
      _ ->
        [ Enum.at( row, x-1 ), Enum.at( row, x ), Enum.at( row, x+1 ) ]
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

  def get_state( population, {x, y} ) do
    row = Enum.at( population, y )
    Enum.at( row, x )
  end

  def get_next_state( population, cell ) do
    neighbours = get_neighbors( population, cell )
    current_state = get_state( population, cell )
    next_state =
      case current_state do
        1 ->
          apply_rules_for_live_cell( neighbours )
        0 ->
          apply_rule_4(neighbours)
      end
  end

  def apply_rules_for_live_cell( neighbours ) do
    live_n = Enum.count( neighbours, fn(n) -> n==1 end)
    dead_n = Enum.count( neighbours, fn(n) -> n==0 end)
    {live_n, dead_n} |> apply_rules()
  end

  def apply_rules( {live_n, dead_n} ) do
    case live_n < 2 do
      true -> {0, :rule1}
      false ->
        apply_rule_2 {live_n, dead_n}
    end
  end

  def apply_rule_2( {live_n, dead_n} ) do
    case live_n do
      2 -> {1, :rule2}
      3 -> {1, :rule2}
      _ -> apply_rule_3 {live_n, dead_n}
    end
  end

  def apply_rule_3( {live_n, dead_n} ) do
    case live_n>3 do
      true -> {0, :rule3}
      false -> {1, :rule3_end}
    end
  end

  def apply_rule_4( neighbours ) do
    live_n = Enum.count( neighbours, fn(n) -> n==1 end)
    case live_n do
      3 -> {1, :rule4}
      _ -> {0, :rule4}
    end
  end

  def get_coordinates( population ) do
    get_coordinates_per_row( {population, 0, length(population), false}, [] )
  end

  def get_coordinates_per_row( {_population, _index, _max_index, true}, current_coordinates ), do: current_coordinates
  def get_coordinates_per_row( {population, index, max_index, false}, current_coordinates ) do
    [row | tail_population] = population
    column_index = Enum.to_list(0..max_index-1)
    coordinates_from_row =
      for x_index <- column_index do
        { x_index, index }
      end
    coordinates = current_coordinates ++ [coordinates_from_row]
    get_coordinates_per_row {tail_population, index+1, max_index, index+1==max_index}, coordinates
  end

  def evolution( population ) do
    coordinates = get_coordinates( population )
    max_index = length( coordinates )
    evolution_row( population, {coordinates, 0, max_index, 0 == max_index}, [] )
  end

  def evolution_row( _population, {_coordinates, _index, _max_index, true}, next_state ), do: next_state
  def evolution_row( population, {coordinates, index, max_index, false}, next_state ) do
    [ current_row | next_coordinates ] = coordinates
    next_state_from_row =
      for coordinate <- current_row do
        {next_state, _reason} = get_next_state( population, coordinate )
        next_state
      end
    next_evolution = next_state ++ [next_state_from_row]
    evolution_row( population, {next_coordinates, index+1, max_index, index+1 == max_index}, next_evolution )
  end

  def new_organism( size ), do: generate_organism( {size, 0, false }, [] )

  def generate_organism( {_size, _index, true}, organism ), do: organism
  def generate_organism( {size, index, false}, organism ) do
    index_in_row = Enum.to_list(0..size-1)
    row =
      for _i <- index_in_row do
        Enum.random(0..1)
      end
    new_organism = organism ++ [row]
    generate_organism( {size, index+1, index+1 == size }, new_organism )
  end

  ## Here Start the game of life!!!
  def start(size) do
    organism = new_organism(size)
    start_game_of_life(0,organism)
  end

  def start_game_of_life(index, organism) do
    IO.puts "Evolución #{index}"
    print_organism( organism )
    Process.sleep(1000)
    IEx.Helpers.clear
    new_organism = evolution( organism )
    start_game_of_life( index+1, new_organism )
  end

  def print_organism( organism ) do
    Enum.each( organism, fn x -> print_row(x) end)
  end

  def print_row( row ) do
    cells = for cell <- row, do: print_cell( cell )
    cells_with_color = for c <- cells, do: [get_random_color()] ++ [c]
    List.flatten( cells_with_color ) |> Bunt.puts
  end

  def print_cell( 1 ), do: "😗|"
  def print_cell( 0 ), do: "  |"

  def get_random_color() do
    color_number = Enum.random(16..255)
    String.to_atom "color#{color_number}"
  end
end
