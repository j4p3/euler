defmodule Three do
  @moduledoc """
  The prime factors of 13195 are 5, 7, 13 and 29.
  What is the largest prime factor of the number 600851475143 ?

  Solving this problem involved the creation of utilities:
  * Math.factorize()

  This required the creation of:
  * Math.find_divisor()
  """

  require Math

  def run(input) do
    largest_factor(input)
  end

  def largest_factor(input), do: Math.prime_factors(input) |> List.first()
end
