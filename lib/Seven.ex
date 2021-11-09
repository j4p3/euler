defmodule Seven do
  @moduledoc """
  By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see that the 6th prime is 13.
  What is the 10 001st prime number?
  """

  @doc """
  Ideas:
  * blind iterate up, checking for divisors up to 1/2? 1/3? the number being tested
  * build big factor tree, or some kind of logn/constant time store, add new divisible numbers onto it
  * eliminate nonprimes from list (set)
  """
  def run(n) do
    max = maximum_nth_prime(n)
    Math.primes_up_to(max)
    |> Enum.at(n - 1)
  end

  defp maximum_nth_prime(n) do
    ceil(n * (:math.log(n) + :math.log(:math.log(n))))
  end
end
