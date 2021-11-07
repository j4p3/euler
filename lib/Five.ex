defmodule Five do
  @moduledoc """
  2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.
  What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?
  """

  @doc """
  Strategies:
  * build lists of multiples of each number and merge them
  * build a single list, and drop items each iteration. start w/ 19*20 multiples.
  """
  def run() do
    find_number()
  end

  defp find_number(number \\ 20 * 19) do
    if is_divisible_below(number, 18) do
      number
    else
      find_number(number + 20 * 19)
    end
  end

  defp is_divisible_below(_number, 1), do: true
  defp is_divisible_below(number, divisor) do
    if rem(number, divisor) == 0 do
      is_divisible_below(number, divisor - 1)
    else
      false
    end
  end
end
