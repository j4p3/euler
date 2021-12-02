defmodule TwentyOne do
  @moduledoc """
  Let d(n) be defined as the sum of proper divisors of n (numbers less than n which divide evenly into n).
  If d(a) = b and d(b) = a, where a ≠ b, then a and b are an amicable pair and each of a and b are called amicable numbers.

  For example, the proper divisors of 220 are 1, 2, 4, 5, 10, 11, 20, 22, 44, 55 and 110; therefore d(220) = 284. The proper divisors of 284 are 1, 2, 4, 71 and 142; so d(284) = 220.

  Evaluate the sum of all the amicable numbers under 10000.
  """
  @doc """
  Ideas:
  * build map of divisor sums, reference map to add pairs
  """
  def run(limit \\ 10000) do
    divisor_sums = build_divisor_sum_map(limit)
    {pairs_sum, _} = Enum.reduce(1..(limit - 1), {0, divisor_sums}, &increment_amicable/2)
    pairs_sum
  end

  defp build_divisor_sum_map(limit, n \\ 1, divisor_sums \\ %{})
  defp build_divisor_sum_map(limit, n, divisor_sums) when n == limit, do: divisor_sums

  defp build_divisor_sum_map(limit, n, divisor_sums) do
    sum = divisor_sum(n)

    build_divisor_sum_map(
      limit,
      n + 1,
      Map.put(divisor_sums, n, sum)
    )
  end

  defp divisor_sum(n) do
    n
    |> Math.factors()
    |> Enum.sort()
    |> List.delete_at(-1)
    |> Enum.sum()
  end

  defp increment_amicable(n, {sum, map}) do
    v = Map.get(map, n)

    if n != v && Map.get(map, v) == n do
      {sum + n + v, Map.delete(Map.delete(map, n), v)}
    else
      {sum, Map.delete(map, n)}
    end
  end
end
