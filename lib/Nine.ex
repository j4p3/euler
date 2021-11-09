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
    for a <- 1..sum,
        b <- 1..sum,
        a * a + b * b == (sum - a - b) * (sum - a - b),
        into: %{},
        do: {a * b * (sum - a - b), {a, b, sum - a - b}}
  end

  # defp search({a, b, c}, target, _cache) when a >= target && b >= target && c >= target
  # defp search({a, b, c}, target, cache) do

  # end

  # def is_pythagorean_triplet(a, b, c) do
  #   a * a + b * b == c * c
  # end
end
