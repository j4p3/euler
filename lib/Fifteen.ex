defmodule Fifteen do
  @moduledoc """
  Starting in the top left corner of a 2×2 grid, and only being able to move to the right and down, there are exactly 6 routes to the bottom right corner.
  How many such routes are there through a 20×20 grid?
  """

  @doc """
  Ideas:
  * incrementally build route count by counting # of increased sides per step (pascal triangle)
  * calculate routes as combination of n choose k (num steps + num turns)
  """
  def run(grid_size) do
    Math.combination(grid_size * 2, grid_size)
  end
end
