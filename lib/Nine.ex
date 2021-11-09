defmodule Nine do
  @moduledoc """
  A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,

  a^2 + b^2 = c^2
  For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

  There exists exactly one Pythagorean triplet for which a + b + c = 1000.
  Find the product abc.
  """

  @doc """
  Ideas:
  * three dimensional array, cache square values, iterate (within bounds?) until sum is found
  * triple comprehension + filter
  * double comprehension + filter with third term as difference
  """
  def run(sum) do
    for a <- 1..ceil(sum/2),
        b <- a..sum-a,
        a * a + b * b == (sum - a - b) * (sum - a - b),
        into: %{},
        do: {a * b * (sum - a - b), {a, b, sum - a - b}}
  end
end
