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
    mapset_containing_up_to(max)
    |> find_primes({max, floor(:math.sqrt(max))})
    |> Enum.at(n - 1)
  end

  defp find_primes(number_set, max_tuple, number \\ 2)
  defp find_primes(number_set, {_max, max_sqrt}, number) when number == max_sqrt do
    number_set
    |> MapSet.to_list()
    |> Enum.sort()
  end
  defp find_primes(number_set, {max, max_sqrt}, number) do
    number_set = if MapSet.member?(number_set, number) do
      eliminate_products(number_set, max, {number * number, number})
    else
      number_set
    end
    find_primes(number_set, {max, max_sqrt}, number + 1)
  end

  defp eliminate_products(number_set, max, {product, _increment}) when product > max do
    number_set
  end
  defp eliminate_products(number_set, max, {product, increment}) do
    MapSet.delete(number_set, product)
    |> eliminate_products(max, {product + increment, increment})
  end

  defp mapset_containing_up_to(limit) do
    MapSet.new(2..limit)
  end

  defp maximum_nth_prime(n) do
    ceil(n * (:math.log(n) + :math.log(:math.log(n))))
  end
end
