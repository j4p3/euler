defmodule Four do
  @moduledoc """
  A palindromic number reads the same both ways. The largest palindrome made from the product of two 2-digit numbers is 9009 = 91 × 99.
  Find the largest palindrome made from the product of two 3-digit numbers.

  Created utilities for this problem:
  * Strings.is_palindrome()
  """

  @doc """
  Strategy: iterate backwards from 999 & check?
  """
  def run() do
    find_largest_palindrome({999, 999}, [])
  end

  defp find_largest_palindrome({0, 0}, palindromes), do: Enum.max(palindromes)
  defp find_largest_palindrome({a, b}, palindromes) do
    if Strings.is_palindrome(Integer.to_charlist(a * b)) do
      find_largest_palindrome(decrement(a, b), [a * b | palindromes])
    else
      find_largest_palindrome(decrement(a, b), palindromes)
    end
  end

  defp decrement(a, b) do
    if (b == 0) do
      {a - 1, a - 1}
    else
      {a, b - 1}
    end
  end
end
