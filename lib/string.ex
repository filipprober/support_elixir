defmodule Support.String do
  @doc """
  Return the remainder of a string after the first occurrence of a given value.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.after("Elixir Package", "Elixir ")
      "Package"
  """
  @doc since: "0.2.0"
  def unquote(:after)(value, search)
      when is_binary(value) and (is_binary(search) or is_integer(search)) do
    search_string = to_string(search)

    cond do
      search_string == "" ->
        value

      true ->
        case String.split(value, search_string, parts: 2) do
          [_, part_after] -> part_after
          [_] -> value
        end
    end
  end

  @doc """
  Reverse the given string.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.reverse("raBooF")
      "FooBar"

      iex> String.reverse("őtüzsineT")
      "Teniszütő"

      iex> String.reverse("☆etyBitluM❤")
      "❤MultiByte☆"
  """
  @doc since: "0.1.0"
  def reverse(value) when is_binary(value) do
    value
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.join()
  end
end
