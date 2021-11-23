defmodule Eighteen do
  @moduledoc """
  By starting at the top of the triangle below and moving to adjacent numbers on the row below, the maximum total from top to bottom is 23.
  [3]
  [7] 4
  2 [4] 6
  8 5 [9] 3

  That is, 3 + 7 + 4 + 9 = 23.
  Find the maximum total from top to bottom of the triangle below:
  75
  95 64
  17 47 82
  18 35 87 10
  20 04 82 47 65
  19 01 23 75 03 34
  88 02 77 73 07 63 67
  99 65 04 28 06 16 70 92
  41 41 26 56 83 40 80 70 33
  41 48 72 33 47 32 37 16 94 29
  53 71 44 65 25 43 91 52 97 51 14
  70 11 33 28 77 73 17 78 39 68 17 57
  91 71 52 38 17 14 91 43 58 50 27 29 48
  63 66 04 68 89 53 67 30 73 16 69 87 40 31
  04 62 98 27 23 09 70 98 73 93 38 53 60 04 23

  NOTE: As there are only 16384 routes, it is possible to solve this problem by trying every route. However, Problem 67, is the same challenge with a triangle containing one-hundred rows; it cannot be solved by brute force, and requires a clever method! ;o)
  """

  @doc """
  Ideas:
  * DFS, store sum en route to each leaf
  * Evaluate rows individually - mark greater of each node pair, search paths with highest density of greater
  * Single pass, bottom-up summation, keep sum of greater child at each node
  """
  def run(input) do
    input
    |> String.split("\n")
    |> Enum.map(fn row -> Enum.map(String.split(row), &String.to_integer/1) end)
    |> Enum.reverse()
    |> sum_rows()
  end

  def sum_rows([[sum]]), do: sum
  def sum_rows([row | [parent | tail]]) do
    greatest_children = row
    |> Enum.chunk_every(2, 1)
    |> Enum.map(&Enum.max/1)
    # can't just choose greatest children, side matters

    # but basically, just take the parent row and add the greater of its children onto it
    {_, summed_parent} = parent
    |> Enum.reduce({0, []}, fn n, {idx, new_row} -> {idx + 1, [n + Enum.at(greatest_children, idx) | new_row]} end)

    sum_rows([Enum.reverse(summed_parent) | tail])
  end
end
