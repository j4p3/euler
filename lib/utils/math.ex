defmodule Math do
  @moduledoc """
  Functions for performing math operations
  """

  @doc """
  Get the smallest prime divisor of a number
  """
  @spec find_divisor(integer, integer) :: {integer, integer}
  def find_divisor(number, divisor) when rem(number, divisor) == 0 do
    {div(number, divisor), divisor}
  end
  def find_divisor(number, divisor), do: find_divisor(number, divisor + 1)

  @doc """
  Find prime factors of a number
  """
  @spec factorize(integer(), [integer()] | []) :: [integer()]
  def factorize(number, factors \\ [])
  def factorize(1, factors), do: factors
  def factorize(number, factors) do
    {result, divisor} = Math.find_divisor(number, 2)
    factorize(result, [divisor | factors])
  end

  @doc """
  Find all primes up to a limit. Uses Eratosthenes sieve.
  """
  @spec primes_up_to(integer) :: list
  def primes_up_to(limit) do
    filter_nonprimes(MapSet.new(2..limit), {limit, floor(:math.sqrt(limit))})
  end

  defp filter_nonprimes(number_set, max_tuple, number \\ 2)
  defp filter_nonprimes(number_set, {_max, max_sqrt}, number) when number > max_sqrt do
    number_set
    |> MapSet.to_list()
    |> Enum.sort()
  end
  defp filter_nonprimes(number_set, {max, max_sqrt}, number) do
    number_set =
      if MapSet.member?(number_set, number) do
        eliminate_products(number_set, max, {number * number, number})
      else
        number_set
      end

    filter_nonprimes(number_set, {max, max_sqrt}, number + 1)
  end

  defp eliminate_products(number_set, max, {product, _increment}) when product > max,
    do: number_set
  defp eliminate_products(number_set, max, {product, increment}) do
    MapSet.delete(number_set, product)
    |> eliminate_products(max, {product + increment, increment})
  end
end
