defmodule Fourteen do
  @moduledoc """
  The following iterative sequence is defined for the set of positive integers:

  n → n/2 (n is even)
  n → 3n + 1 (n is odd)

  Using the rule above and starting with 13, we generate the following sequence:

  13 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
  It can be seen that this sequence (starting at 13 and finishing at 1) contains 10 terms. Although it has not been proved yet (Collatz Problem), it is thought that all starting numbers finish at 1.

  Which starting number, under one million, produces the longest chain?

  NOTE: Once the chain starts the terms are allowed to go above one million.
  """

  @doc """
  Ideas:
  * recursive collatz w/ increment for arbitrary n
  * keep stack of numbers in sequence, upon reaching 1, flush stack & de-increment backwards to cache collatz num for future checks
  * maybe just cache starting n, since we're inevitable going to hit every possible starting n on the way up anyway. stack overkill?
  """
  def run(limit) do
    longest_collatz_under(limit)
  end

  defp longest_collatz_under(limit, number \\ 1, cache \\ %{}, longest_seed \\ 1)

  defp longest_collatz_under(limit, number, cache, longest_seed) when number == 1,
    do: longest_collatz_under(limit, number + 1, Map.put(cache, 1, 1), longest_seed)

  defp longest_collatz_under(limit, number, cache, longest_seed) when number > limit,
    do: {longest_seed, Map.get(cache, longest_seed)}

  defp longest_collatz_under(limit, number, cache, longest_seed) do
    # if rem(number, 100) == 0, do: IO.puts("checking #{number}")
    new_cache = collatz(number, cache)

    new_longest_seed =
      if Map.get(new_cache, longest_seed) > Map.get(new_cache, number),
        do: longest_seed,
        else: number

    longest_collatz_under(limit, number + 1, new_cache, new_longest_seed)
  end

  defp collatz(number, cache, sequence \\ [])

  defp collatz(1, cache, sequence) do
    # end of sequence
    unpack(sequence, cache)
  end

  defp collatz(number, cache, sequence) do
    if Map.has_key?(cache, number) do
      # short-circuit recursion, treat as endpoint
      unpack(sequence, cache, Map.get(cache, number) + 1)
    else
      next = if Bitwise.band(number, 1) == 0, do: div(number, 2), else: number * 3 + 1
      collatz(next, cache, [number | sequence])
    end
  end

  defp unpack(sequence, cache, sequence_length_at_end \\ 2) do
    # Unpack sequence into cache, return cache
    # iterate back through sequence, store length from each n
    {cache, _sequence_length} =
      Enum.reduce(sequence, {cache, sequence_length_at_end}, fn n, {c, l} ->
        {Map.put(c, n, l), l + 1}
      end)

    cache
  end
end
