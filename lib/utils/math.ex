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
end
