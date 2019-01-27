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
    cell1 = {0,0}
    cell2 = {1,1}
    cell3 = {2,2}
    cell4 = {3,3}
    neighbouts1 = GameOfLife.get_neighbors( population, cell1 )
    neighbouts2 = GameOfLife.get_neighbors( population, cell2 )
    neighbouts3 = GameOfLife.get_neighbors( population, cell3 )
    neighbouts4 = GameOfLife.get_neighbors( population, cell4 )
    assert neighbouts1 == [:c16, :c13, :c14, :c4, :c2, :c8, :c5, :c6]
    assert neighbouts2 == [:c1, :c2, :c3, :c5, :c7, :c9, :c10, :c11]
    assert neighbouts3 == [:c6, :c7, :c8, :c10, :c12, :c14, :c15, :c16]
    assert neighbouts4 == [:c11, :c12, :c9, :c15, :c13, :c3, :c4, :c1]
  end

end
