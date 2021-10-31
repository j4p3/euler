defmodule Strings do
  @moduledoc """
  Functions for analyzing strings.
  """

  @doc """
  Evaluates whether a given charlist is a palindrome
  """
  @spec is_palindrome(charlist()) :: boolean()
  def is_palindrome([]), do: true
  def is_palindrome(input) when length(input) == 1, do: true

  def is_palindrome(input) do
    if List.first(input) == List.last(input) do
      input
      |> tl()
      |> Enum.reverse()
      |> tl()
      |> is_palindrome()
    else
      false
    end
  end
end
