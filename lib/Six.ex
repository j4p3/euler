defmodule Six do
  @moduledoc """
  The sum of the squares of the first ten natural numbers is 1^2 + 2^2 .. + 10^2 = 385
  The square of the sum of the first ten natural numbers is (1 + 2 .. + 10)^2 = 55^2 = 3025
  Hence the difference between the sum of the squares of the first ten natural numbers and the square of the sum is 3025 - 385 = 2640

  Find the difference between the sum of the squares of the first one hundred natural numbers and the square of the sum.
  """

  @doc """
  Ideas:
  * this is a trivial problem, given the constraints?
  """
  def run(limit) do
    :math.pow(Enum.reduce(1..limit, fn i, sum -> sum + i end), 2) - Enum.reduce(1..limit, fn i, sum -> sum + :math.pow(i, 2) end)
  end
end
