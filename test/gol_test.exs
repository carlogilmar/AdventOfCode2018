defmodule GameOfLifeTest do
  use ExUnit.Case
  doctest GameOfLife

  test "Get the population" do
    init_population = GameOfLife.fake_population()
    population = length( init_population )
    assert population == 4
  end
end
