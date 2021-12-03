defmodule Input do
  @moduledoc """
  Utilities for deserializing text into structured data.
  """

  @doc """
  Emit a stream of strings from a file containing a list of quoted strings.

  Example:
  "MARY","PATRICIA"
  """
  def stream_string_list_file(path) do
    File.stream!(File.cwd!() <> path, [], 1)
    |> Stream.reject(&(&1 == "\""))
    |> Stream.chunk_by(&(&1 == ","))
    |> Stream.reject(&(&1 == [","]))
    |> Stream.map(&(Enum.join(&1)))
    |> Enum.to_list()
  end
end
