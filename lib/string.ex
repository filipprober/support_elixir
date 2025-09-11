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
  Return the remainder of a string after the last occurrence of a given value.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.after_last("Elixir Package Elixir", "Elixir ")
      "Package Elixir"
  """
  @doc since: "0.2.0"
  def after_last(value, search)
      when is_binary(value) and (is_binary(search) or is_integer(search)) do
    search_string = to_string(search)

    cond do
      search_string == "" ->
        value

      true ->
        search_length = String.length(search_string)
        value_length = String.length(value)

        # Start from the last possible position and work backwards
        Enum.find_value((value_length - search_length)..0//-1, value, fn start_pos ->
          if String.slice(value, start_pos, search_length) == search_string do
            String.slice(value, start_pos + search_length, value_length)
          end
        end)
    end
  end

  @doc """
  Get the portion of a string before the first occurrence of a given value.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.before("Elixir Package", " Package")
      "Elixir"
  """
  @doc since: "0.2.0"
  def before(value, search) when is_binary(value) and (is_binary(search) or is_integer(search)) do
    search_string = to_string(search)

    cond do
      search_string == "" ->
        value

      true ->
        case String.split(value, search_string, parts: 2) do
          [part_before, _] -> part_before
          [_] -> value
        end
    end
  end

  @doc """
  Get the portion of a string before the last occurrence of a given value.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.before_last("Elixir Package Elixir", " Elixir")
      "Elixir Package"
  """
  @doc since: "0.2.0"
  def before_last(value, search)
      when is_binary(value) and (is_binary(search) or is_integer(search)) do
    search_string = to_string(search)

    cond do
      search_string == "" ->
        value

      true ->
        search_length = String.length(search_string)
        value_length = String.length(value)

        # Start from the last possible position and work backwards
        Enum.find_value((value_length - search_length)..0//-1, value, fn start_pos ->
          if String.slice(value, start_pos, search_length) == search_string do
            String.slice(value, 0, start_pos)
          end
        end)
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

  @doc """
  Convert the given string to upper-case.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.upper("Elixir Package")
      "ELIXIR PACKAGE"
  """
  @doc since: "0.3.0"
  def upper(value) when is_binary(value) do
    String.upcase(value)
  end
end
