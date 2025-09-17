defmodule Support.String do
  @doc """
  Return the remainder of a string after the first occurrence of a given value.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.after("Elixir Package", "Elixir ")
      "Package"
  """
  @doc since: "0.2.0"
  @spec unquote(:after)(String.t(), String.t() | integer()) :: String.t()
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

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.after_last("Elixir Package Elixir", "Elixir ")
      "Package Elixir"
  """
  @doc since: "0.2.0"
  @spec after_last(String.t(), String.t() | integer()) :: String.t()
  def after_last(value, search)
      when is_binary(value) and (is_binary(search) or is_integer(search)) do
    search_string = to_string(search)

    cond do
      search_string == "" ->
        value

      true ->
        search_length = String.length(search_string)
        value_length = String.length(value)

        Enum.find_value((value_length - search_length)..0//-1, value, fn start_pos ->
          if String.slice(value, start_pos, search_length) == search_string do
            String.slice(value, start_pos + search_length, value_length)
          end
        end)
    end
  end

  @doc """
  Get the portion of a string before the first occurrence of a given value.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.before("Elixir Package", " Package")
      "Elixir"
  """
  @doc since: "0.2.0"
  @spec before(String.t(), String.t() | integer()) :: String.t()
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

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.before_last("Elixir Package Elixir", " Elixir")
      "Elixir Package"
  """
  @doc since: "0.2.0"
  @spec before_last(String.t(), String.t() | integer()) :: String.t()
  def before_last(value, search)
      when is_binary(value) and (is_binary(search) or is_integer(search)) do
    search_string = to_string(search)

    cond do
      search_string == "" ->
        value

      true ->
        search_length = String.length(search_string)
        value_length = String.length(value)

        Enum.find_value((value_length - search_length)..0//-1, value, fn start_pos ->
          if String.slice(value, start_pos, search_length) == search_string do
            String.slice(value, 0, start_pos)
          end
        end)
    end
  end

  @doc """
  Get the portion of a string between two given values.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.between("Elixir Package", "E", "r")
      "lixi"
  """
  @doc since: "0.3.0"
  @spec between(String.t(), String.t() | integer(), String.t() | integer()) :: String.t()
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

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.between_first("Elixir Package", "E", "i")
      "l"

  """
  @doc since: "0.3.0"
  @spec between_first(String.t(), String.t() | integer(), String.t() | integer()) ::
          String.t()
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
  Determine if a given string contains all array values.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.contains_all?("The quick brown fox", ["Quick", "Fox"])
      false

      iex> String.contains_all?("The quick brown fox", ["The", "fox"])
      true

  ## Ignore case

  To ignore the case of the given string, you can pass in a third argument:

      iex> alias Support.String
      Support.String

      iex> String.contains_all?("The quick brown fox", ["Quick", "Fox"], true)
      true

      iex> String.contains_all?("The quick brown fox", ["Quick", "Fox"], true)
      true
  """
  @doc since: "0.3.3"
  @spec contains_all?(String.t(), list(String.t() | integer()), boolean()) :: boolean()
  def contains_all?(value, needles, ignore_case \\ false)
      when is_binary(value) and is_list(needles) and is_boolean(ignore_case) do
    case ignore_case do
      true ->
        lower_value = lower(value)

        Enum.all?(needles, fn needle ->
          String.contains?(lower_value, lower(to_string(needle)))
        end)

      false ->
        Enum.all?(needles, fn needle ->
          String.contains?(value, to_string(needle))
        end)
    end
  end

  @doc """
  Convert a string to kebab case.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.kebab("Elixir Package")
      "elixir-package"
  """
  @doc since: "0.3.0"
  @spec kebab(String.t()) :: String.t()
  def kebab(value) when is_binary(value) do
    snake(value, "-")
  end

  @doc """
  Convert the first character of the given string to lower-case.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.lcfirst("Support")
      "support"
  """
  @doc since: "0.3.0"
  @spec lcfirst(String.t()) :: String.t()
  def lcfirst(value) when is_binary(value) do
    case String.graphemes(value) do
      [] -> ""
      [first_char | rest] -> lower(first_char) <> Enum.join(rest)
    end
  end

  @doc """
  Convert the given string to lower-case.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.lower("Elixir Package")
      "elixir package"
  """
  @doc since: "0.3.0"
  @spec lower(String.t()) :: String.t()
  def lower(value) when is_binary(value) do
    String.downcase(value)
  end

  @doc """
  Remove all whitespace from the beginning of a string.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.ltrim("   Elixir Package   ")
      "Elixir Package   "
  """
  @doc since: "0.4.0"
  @spec ltrim(String.t()) :: String.t()
  def ltrim(value) when is_binary(value) do
    String.trim_leading(value)
  end

  @doc """
  Get the plural form of an English word.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.plural("person")
      "people"

      iex> String.plural("User")
      "Users"
  """
  @doc since: "0.3.0"
  @spec plural(String.t(), integer()) :: String.t()
  def plural(word, count \\ 2) when is_binary(word) and is_integer(count) do
    if count == 1 do
      word
    else
      Support.Inflector.pluralize(word)
    end
  end

  @doc """
  Reverse the given string.

  ## Usage

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
  @spec reverse(String.t()) :: String.t()
  def reverse(value) when is_binary(value) do
    value
    |> String.graphemes()
    |> Enum.reverse()
    |> Enum.join()
  end

  @doc """
  Remove all whitespace from the end of a string.

      iex> alias Support.String
      Support.String

      iex> String.rtrim("   Elixir Package   ")
      "   Elixir Package"
  """
  @doc since: "0.4.0"
  @spec rtrim(String.t()) :: String.t()
  def rtrim(value) when is_binary(value) do
    String.trim_trailing(value)
  end

  @doc """
  Get the singular form of an English word.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.singular("people")
      "person"

      iex> String.singular("Users")
      "User"
  """
  @doc since: "0.3.0"
  @spec singular(String.t()) :: String.t()
  def singular(word) when is_binary(word) do
    Support.Inflector.singularize(word)
  end

  @doc """
  Convert a string to snake case.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.snake("Elixir Package")
      "elixir_package"

      iex> String.snake("Elixir Package", "-")
      "elixir-package"
  """
  @doc since: "0.3.0"
  @spec snake(String.t(), String.t()) :: String.t()
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
  Convert a value to studly caps case.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.studly("foo-bar")
      "FooBar"

      iex> String.studly("elixir_s_u_p_p_o_r_t_library")
      "ElixirSUPPORTLibrary"
  """
  @doc since: "0.3.2"
  @spec studly(String.t()) :: String.t()
  def studly(value) when is_binary(value) do
    value
    |> String.replace(["-", "_"], " ")
    |> String.split()
    |> Enum.map(&ucfirst/1)
    |> Enum.join()
  end

  @doc """
  Take the first or last `limit` characters of a string.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.take("Elixir Package", 7)
      "Elixir "

      iex> String.take("Elixir Package", -7)
      "Package"
  """
  @doc since: "0.3.0"
  @spec take(String.t(), integer()) :: String.t()
  def take(value, limit) when is_binary(value) and is_integer(limit) do
    cond do
      limit >= 0 -> String.slice(value, 0, limit)
      limit < 0 -> String.slice(value, limit, -limit)
    end
  end

  @doc """
  Convert a string to the specified case.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.to_case("Elixir Package", :kebab)
      "elixir-package"

      iex> String.to_case("Elixir Package", :snake)
      "elixir_package"

      iex> String.to_case("Elixir Package", :upper)
      "ELIXIR PACKAGE"

      iex> String.to_case("Elixir Package", :lower)
      "elixir package"
  """
  @doc since: "0.3.1"
  @spec to_case(String.t(), atom()) :: String.t()
  def to_case(value, case) when is_binary(value) and case in [:kebab, :snake, :upper, :lower] do
    case case do
      :kebab -> kebab(value)
      :snake -> snake(value)
      :upper -> upper(value)
      :lower -> lower(value)
    end
  end

  @doc """
  Convert a string to the specified case with a custom delimiter.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.to_case("Elixir Package", "_", :snake)
      "elixir_package"

      iex> String.to_case("Elixir Package", " ?? ", :snake)
      "elixir ?? package"
  """
  @doc since: "0.3.1"
  @spec to_case(String.t(), String.t(), atom()) :: String.t()
  def to_case(value, delimeter, case)
      when is_binary(value) and is_binary(delimeter) and case in [:snake] do
    case case do
      :snake -> snake(value, delimeter)
    end
  end

  @doc """
  Make a string's first character uppercase.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.ucfirst("support")
      "Support"
  """
  @doc since: "0.3.0"
  @spec ucfirst(String.t()) :: String.t()
  def ucfirst(value) when is_binary(value) do
    case String.graphemes(value) do
      [] -> ""
      [first_char | rest] -> upper(first_char) <> Enum.join(rest)
    end
  end

  @doc """
  Convert the given string to upper-case.

  ## Usage

      iex> alias Support.String
      Support.String

      iex> String.upper("Elixir Package")
      "ELIXIR PACKAGE"
  """
  @doc since: "0.3.0"
  @spec upper(String.t()) :: String.t()
  def upper(value) when is_binary(value) do
    String.upcase(value)
  end
end
