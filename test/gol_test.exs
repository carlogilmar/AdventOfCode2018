defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  test "Get the population" do
    init_population = GameOfLife.fake_population()
    population = length( init_population )
    assert population == 4
  end

  test "Get neighbors from cell" do
    population = GameOfLife.fake_population()
    cell2 = {1,1}
    cell3 = {2,2}
    cell1 = {0,0}
    cell4 = {3,3}
    cell5 = {3,0}
    cell6 = {0,3}
    neighbouts1 = GameOfLife.get_neighbors( population, cell1 )
    neighbouts2 = GameOfLife.get_neighbors( population, cell2 )
    neighbouts3 = GameOfLife.get_neighbors( population, cell3 )
    neighbouts4 = GameOfLife.get_neighbors( population, cell4 )
    neighbouts5 = GameOfLife.get_neighbors( population, cell5 )
    neighbouts6 = GameOfLife.get_neighbors( population, cell6 )
    # Puntos intermedios
    assert neighbouts1 == [:c16, :c13, :c14, :c4, :c2, :c8, :c5, :c6]
    assert neighbouts2 == [:c1, :c2, :c3, :c5, :c7, :c9, :c10, :c11]
    # Esquinas
    assert neighbouts3 == [:c6, :c7, :c8, :c10, :c12, :c14, :c15, :c16]
    assert neighbouts4 == [:c11, :c12, :c9, :c15, :c13, :c3, :c4, :c1]
    assert neighbouts5 == [:c15, :c16, :c13, :c3, :c1, :c7, :c8, :c5]
    assert neighbouts6 == [:c12, :c9, :c10, :c16, :c14, :c4, :c1, :c2]
  end

  test "Get the next state of a cell" do
    population = GameOfLife.fake_population2()
    next_state1 = GameOfLife.get_next_state( population, {1,1} )
    next_state2 = GameOfLife.get_next_state( population, {1,2} )
    assert next_state1 == {1,:rule4}
    assert next_state2 == {0,:rule1}
  end

  test "Apply rule 4" do
    n1 = [1,1,1,0,0,0,0,0]
    n2 = [0,0,0,0,0,0,0,0]
    next_n1 = GameOfLife.apply_rule_4( n1 )
    next_n2 = GameOfLife.apply_rule_4( n2 )
    assert next_n1 == {1, :rule4}
    assert next_n2 == {0, :rule4}
  end

  test "Apply rules for live states" do
    n1 = [1,0,0,0,0,0,0,0]
    n2 = [1,1,0,0,0,0,0,0]
    n3 = [1,1,1,0,0,0,0,0]
    n4 = [1,1,1,1,0,0,0,0]
    next_n1 = GameOfLife.apply_rules_for_live_cell( n1 )
    next_n2 = GameOfLife.apply_rules_for_live_cell( n2 )
    next_n3 = GameOfLife.apply_rules_for_live_cell( n3 )
    next_n4 = GameOfLife.apply_rules_for_live_cell( n4 )
    assert next_n1 ==  {0, :rule1}
    assert next_n2 ==  {1, :rule2}
    assert next_n3 ==  {1, :rule2}
    assert next_n4 ==  {0, :rule3}
  end

  test "Get the coordinates" do
    population = GameOfLife.fake_population()
    coordinates = GameOfLife.get_coordinates( population )
    waiting_coordinates =
      [
        [{0, 0}, {1, 0}, {2, 0}, {3, 0}, {4, 0}],
        [{0, 1}, {1, 1}, {2, 1}, {3, 1}, {4, 1}],
        [{0, 2}, {1, 2}, {2, 2}, {3, 2}, {4, 2}],
        [{0, 3}, {1, 3}, {2, 3}, {3, 3}, {4, 3}]
      ]
    assert coordinates == waiting_coordinates
  end

  #test "Make the evolution" do
  #  population = GameOfLife.fake_population()
  #  new_state1 = GameOfLife.evolution( population )
  #  new_state2 = GameOfLife.evolution( new_state1 )
  #  assert length(new_state1) == 4
  #  assert length(new_state2) == 4
  #end

end
