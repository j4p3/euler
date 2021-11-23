defmodule Seventeen do
  @moduledoc """
  If the numbers 1 to 5 are written out in words: one, two, three, four, five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.
  If all the numbers from 1 to 1000 (one thousand) inclusive were written out in words, how many letters would be used?
  NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and forty-two) contains 23 letters and 115 (one hundred and fifteen) contains 20 letters. The use of "and" when writing out numbers is in compliance with British usage.
  """

  @digits %{
    0 => "",
    1 => "one",
    2 => "two",
    3 => "three",
    4 => "four",
    5 => "five",
    6 => "six",
    7 => "seven",
    8 => "eight",
    9 => "nine"
  }

  @teens %{
    10 => "ten",
    11 => "eleven",
    12 => "twelve",
    13 => "thirteen",
    14 => "fourteen",
    15 => "fifteen",
    16 => "sixteen",
    17 => "seventeen",
    18 => "eighteen",
    19 => "nineteen"
  }

  @tens %{
    1 => "ten",
    2 => "twenty",
    3 => "thirty",
    4 => "forty",
    5 => "fifty",
    6 => "sixty",
    7 => "seventy",
    8 => "eighty",
    9 => "ninety"
  }

  @orders %{
    100 => "hundred",
    1000 => "thousand"
  }

  @doc """
  How tedious
  """
  def run(limit) do
    Enum.reduce(1..limit, 0, fn i, acc -> acc + count_letters(word_for_number(i)) end)
  end

  def count_letters(str) do
    str
    |> String.replace(" ", "")
    |> String.codepoints()
    |> Enum.count()
  end

  def word_for_number(i) when i < 10, do: @digits[i]
  def word_for_number(i) when i < 20, do: @teens[i]
  def word_for_number(i) when i < 100, do: @tens[div(i, 10)] <> @digits[rem(i, 10)]

  def word_for_number(i) when i < 1000 do
    @digits[div(i, 100)] <> @orders[100] <> prepend_and_if_present(word_for_number(rem(i, 100)))
  end

  def word_for_number(i) when i < 10_000 do
    @digits[div(i, 1000)] <> @orders[1000] <> word_for_number(rem(i, 1000))
  end

  defp prepend_and_if_present(str) do
    if String.length(str) > 0, do: "and" <> str, else: ""
  end
end
