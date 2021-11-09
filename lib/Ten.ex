defmodule Ten do
  @moduledoc """
  The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.

  Find the sum of all the primes below two million.
  """

  def run(limit) do
    Math.primes_up_to(limit)
    |> Enum.sum()
  end
end
