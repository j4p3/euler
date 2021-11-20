defmodule Math do
  @moduledoc """
  Functions for performing math operations
  """

  @type factor_cache :: %{integer() => [integer()]}

  @doc """
  Get the smallest prime divisor of a number
  """
  @spec find_divisor(integer, integer) :: {integer, integer}
  def find_divisor(number, divisor \\ 2)

  def find_divisor(number, divisor) when rem(number, divisor) == 0 do
    {div(number, divisor), divisor}
  end

  def find_divisor(number, divisor), do: find_divisor(number, divisor + 1)

  @doc """
  Find prime factors of a number
  """
  @spec prime_factors(integer(), [integer()] | []) :: [integer()]
  def prime_factors(number, factors \\ [])
  def prime_factors(1, factors), do: factors

  def prime_factors(number, factors) do
    {result, divisor} = find_divisor(number)
    prime_factors(result, [divisor | factors])
  end

  @doc """
  Find all factors of a number
  """
  @spec factors(integer()) :: [integer()]
  def factors(number),
    do: accumulate_factors(number, floor(:math.sqrt(number)), [])

  @spec accumulate_factors(integer(), integer(), [integer()]) :: any
  defp accumulate_factors(_number, 0, factors), do: factors

  defp accumulate_factors(number, divisor, factors) do
    accumulate_factors(number, divisor - 1, factors_for(number, divisor) ++ factors)
  end

  defp factors_for(number, divisor) do
    if rem(number, divisor) == 0 do
      [div(number, divisor), divisor]
    else
      []
    end
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

  @doc """
  Factorial of n.
  """
  @spec factorial(integer) :: integer
  def factorial(n) do
    Enum.reduce(1..n, 1, fn i, acc -> acc * i end)
  end

  @doc """
  Combinations of k decisions over n moves.
  """
  @spec combination(integer, integer) :: integer
  def combination(n, k) do
    div(
      Enum.reduce((n - k + 1)..n, 1, fn i, acc -> acc * i end),
      factorial(k)
    )
  end
end
