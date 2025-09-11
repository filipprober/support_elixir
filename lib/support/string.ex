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
  Get the portion of a string between two given values.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.between("Elixir Package", "E", "r")
      "lixi"
  """
  @doc since: "0.3.0"
  def between(value, from, to)
      when is_binary(value) and (is_binary(from) or is_integer(from)) and
             (is_binary(to) or is_integer(to)) do
    from = to_string(from)
    to = to_string(to)

    if from == "" or to == "" do
      value
    else
      value
      |> Support.String.after(from)
      |> Support.String.before_last(to)
    end
  end

  @doc """
  Get the smallest possible portion of a string between two given values.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.between_first("Elixir Package", "E", "i")
      "l"

  """
  @doc since: "0.3.0"
  def between_first(value, from, to)
      when is_binary(value) and (is_binary(from) or is_integer(from)) and
             (is_binary(to) or is_integer(to)) do
    from = to_string(from)
    to = to_string(to)

    if from == "" or to == "" do
      value
    else
      value
      |> Support.String.after(from)
      |> Support.String.before(to)
    end
  end

  @doc """
  Convert a string to kebab case.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.kebab("Elixir Package")
      "elixir-package"
  """
  @doc since: "0.3.0"
  def kebab(value) when is_binary(value) do
    snake(value, "-")
  end

  @doc """
  Convert the first character of the given string to lower-case.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.lcfirst("Support")
      "support"
  """
  @doc since: "0.3.0"
  def lcfirst(value) when is_binary(value) do
    case String.graphemes(value) do
      [] -> ""
      [first_char | rest] -> lower(first_char) <> Enum.join(rest)
    end
  end

  @doc """
  Convert the given string to lower-case.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.lower("Elixir Package")
      "elixir package"
  """
  @doc since: "0.3.0"
  def lower(value) when is_binary(value) do
    String.downcase(value)
  end

  @doc """
  Get the plural form of an English word.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.plural("person")
      "people"

      iex> String.plural("User")
      "Users"
  """
  @doc since: "0.3.0"
  def plural(word, count \\ 2) when is_binary(word) and is_integer(count) do
    if count == 1 do
      word
    else
      Support.Inflector.pluralize(word)
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
  Convert a string to snake case.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.snake("Elixir Package")
      "elixir_package"

      iex> String.snake("Elixir Package", "-")
      "elixir-package"
  """
  @doc since: "0.3.0"
  def snake(value, delimiter \\ "_") when is_binary(value) and is_binary(delimiter) do
    if value != String.downcase(value) do
      value
      |> String.replace(~r/\s+/u, "")
      |> String.replace(~r/(.)(?=[A-Z])/u, "\\1#{delimiter}")
      |> lower()
    else
      value
    end
  end

  @doc """
  Take the first or last `limit` characters of a string.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.take("Elixir Package", 7)
      "Elixir "

      iex> String.take("Elixir Package", -7)
      "Package"
  """
  @doc since: "0.3.0"
  def take(value, limit) when is_binary(value) and is_integer(limit) do
    cond do
      limit >= 0 -> String.slice(value, 0, limit)
      limit < 0 -> String.slice(value, limit, -limit)
    end
  end

  @doc """
  Make a string's first character uppercase.

  ## Examples

      iex> alias Support.String
      Support.String

      iex> String.ucfirst("support")
      "Support"
  """
  @doc since: "0.3.0"
  def ucfirst(value) when is_binary(value) do
    case String.graphemes(value) do
      [] -> ""
      [first_char | rest] -> upper(first_char) <> Enum.join(rest)
    end
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
