defmodule Support.String do
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
