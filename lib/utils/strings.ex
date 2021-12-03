defmodule Strings do
  @moduledoc """
  Functions for analyzing strings.
  """

  @doc """
  Convert a string of integer characters ("1", "45") to a list of individual integers
  """
  @spec to_integer_list(String.t()) :: [integer()]
  def to_integer_list(input_string) do
    input_string
    |> String.codepoints()
    |> Enum.map(fn i -> String.to_integer(i) end)
  end

  @doc """
  Sum the alphabetical position of letters in a string
  """
  @spec alphabetical_value(String.t()) :: integer()
  def alphabetical_value(input_string) do
    input_string
    |> String.downcase()
    |> String.to_charlist()
    |> Enum.reduce(0, fn i, acc -> acc + i - 96 end)
  end

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
