defmodule Sixteen do
  @moduledoc """
  2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.
  What is the sum of the digits of the number 2^1000?
  """

  @doc """
  Ideas:
  * is there a pattern to digits in squares of two? Lots of 9s, 16s, 7s, no obvious pattern
  * raise n to the 1000 and sum its digits, then
  """
  def run(pow) do
    Math.sum_digits(floor(:math.pow(2, pow)))
  end
end
