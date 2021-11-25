defmodule Nineteen do
  @moduledoc """
  You are given the following information, but you may prefer to do some research for yourself.

  * 1 Jan 1900 was a Monday.
  * Thirty days has September,
    April, June and November.
    All the rest have thirty-one,
    Saving February alone,
    Which has twenty-eight, rain or shine.
    And on leap years, twenty-nine.
  * A leap year occurs on any year evenly divisible by 4, but not on a century unless it is divisible by 400.

  How many Sundays fell on the first of the month during the twentieth century (1 Jan 1901 to 31 Dec 2000)?
  """

  @days_per_month [
    {:jan, 31},
    {:feb, 28},
    {:mar, 31},
    {:apr, 30},
    {:may, 31},
    {:jun, 30},
    {:jul, 31},
    {:aug, 31},
    {:sep, 30},
    {:oct, 31},
    {:nov, 30},
    {:dec, 31}
  ]

  @doc """
  Ideas:
  * Iterate through the 20th century, tracking day of week, and increment when appropriate
  """
  def run() do
    # Stupid gotcha in problem description, given 1900 start day, not 1901.
    count_sundays(1900..2000, 1)
  end

  def count_sundays(year_range, start_day) do
    {count, _day} = Enum.reduce(year_range, {0, start_day}, &count_year/2)
    count
  end

  @doc """
  Count the number of FOMS in a year.
  """
  def count_year(year, {count, day}) do
    # IO.puts("counting year #{year}")
    # if is_leap_year?(year), do: IO.puts(" - leap year")
    {count, _year, day} = Enum.reduce(@days_per_month, {count, year, day}, &count_month/2)
    {count, day}
  end

  @doc """
  Increment a count on a FOMS.
  """
  def count_month({month, days_in_month}, {count, year, day}) do
    # IO.puts("#{month} 1: #{day_of_week?(day)}")

    {count + increment_sunday(day), year, day + days_in_month + leap_increment(year, month)}
  end

  # stupid gotcha in problem description, given 1900 but counting from 1901
  defp increment_sunday(day) when day < 358, do: 0
  defp increment_sunday(day), do: if(is_sunday?(day), do: 1, else: 0)

  defp is_sunday?(day), do: rem(day, 7) == 0

  defp leap_increment(year, month), do: if(month == :feb && is_leap_year?(year), do: 1, else: 0)

  defp is_leap_year?(year) do
    rem(year, 4) == 0 && (not (rem(year, 100) == 0) || rem(year, 400) == 0)
  end

  # defp day_of_week?(day) do
  #   %{
  #     0 => :sun,
  #     1 => :mon,
  #     2 => :tue,
  #     3 => :wed,
  #     4 => :thu,
  #     5 => :fri,
  #     6 => :sat,
  #   }
  #   |> Map.get(rem(day, 7))
  # end
end
