defmodule TwentyTwo do
  @moduledoc """
  Using names.txt (right click and 'Save Link/Target As...'), a 46K text file containing over five-thousand first names, begin by sorting it into alphabetical order. Then working out the alphabetical value for each name, multiply this value by its alphabetical position in the list to obtain a name score.
  For example, when the list is sorted into alphabetical order, COLIN, which is worth 3 + 15 + 12 + 9 + 14 = 53, is the 938th name in the list. So, COLIN would obtain a score of 938 × 53 = 49714.
  What is the total of all the name scores in the file?
  """

  @doc """
  Ideas:
  * chunk input into sizes sortable in memory, sort them, stream from sorted chunks, merge into final file
  * or just sort the whole list in memory, since it's only 46k
  """
  def run() do
    {total, _count} = Input.stream_string_list_file("/assets/22_names.txt")
    |> Enum.sort()
    |> Enum.reduce({0, 1}, &add_alphabetical_value/2)

    total
  end

  defp add_alphabetical_value(name, {total, n}) do
    {total + n * Strings.alphabetical_value(name), n + 1}
  end
end
