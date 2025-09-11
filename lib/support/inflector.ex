defmodule Support.Inflector do
  @moduledoc false

  @uncountable [
    "aircraft",
    "bellows",
    "bison",
    "deer",
    "equipment",
    "fish",
    "hovercraft",
    "information",
    "jeans",
    "means",
    "measles",
    "money",
    "moose",
    "news",
    "pants",
    "police",
    "rice",
    "series",
    "sheep",
    "spacecraft",
    "species",
    "swine",
    "tights",
    "tongs",
    "trousers"
  ]

  defp irregular_rules do
    [
      {~r/(alumn|cact|fung|radi|stimul|syllab)i/i, "\\1us"},
      {~r/(alg|antenn|amoeb|larv|vertebr)ae/i, "\\1a"},
      {~r/^(gen)era$/i, "\\1us"},
      {~r/(pe)ople/i, "\\1rson"},
      {~r/^(zombie)s$/i, "\\1"},
      {~r/(g)eese/i, "\\1oose"},
      {~r/(criteri)a/i, "\\1on"},
      {~r/^(m)en$/i, "\\1an"},
      {~r/^(echo)es/i, "\\1"},
      {~r/^(hero)es/i, "\\1"},
      {~r/^(potato)es/i, "\\1"},
      {~r/^(tomato)es/i, "\\1"},
      {~r/^(t)eeth/i, "\\1ooth"},
      {~r/^(l)ice$/i, "\\1ouse"},
      {~r/^(addend|bacteri|curricul|dat|memorand|quant)a$/i, "\\1um"},
      {~r/^(di)ce/i, "\\1e"},
      {~r/^(f)eet/i, "\\1oot"},
      {~r/^(phenomen)a/i, "\\1on"}
    ]
  end

  defp plural_irregular_rules do
    [
      {~r/(alumn|cact|fung|radi|stimul|syllab)us/i, "\\1i"},
      {~r/(alg|antenn|amoeb|larv|vertebr)a/i, "\\1ae"},
      {~r/^(gen)us$/i, "\\1era"},
      {~r/(pe)rson$/i, "\\1ople"},
      {~r/^(zombie)s$/i, "\\1"},
      {~r/(g)oose$/i, "\\1eese"},
      {~r/(criteri)on/i, "\\1a"},
      {~r/^(men)$/i, "\\1"},
      {~r/^(women)/i, "\\1"},
      {~r/^(echo)$/i, "\\1es"},
      {~r/^(hero)$/i, "\\1es"},
      {~r/^(potato)/i, "\\1es"},
      {~r/^(tomato)/i, "\\1es"},
      {~r/^(t)ooth$/i, "\\1eeth"},
      {~r/^(l)ouse$/i, "\\1ice"},
      {~r/^(addend|bacteri|curricul|dat|memorand|quant)um$/i, "\\1a"},
      {~r/^(di)e$/i, "\\1ce"},
      {~r/^(f)oot$/i, "\\1eet"},
      {~r/^(phenomen)on/i, "\\1a"}
    ]
  end

  defp singular_rules do
    irregular_rules() ++
      [
        {~r/(child)ren/i, "\\1"},
        {~r/(wo|sea)men$/i, "\\1man"},
        {~r/^(m|l)ice$/i, "\\1ouse"},
        {~r/(bus|canvas|status|alias)(es)?$/i, "\\1"},
        {~r/(ss)$/i, "\\1"},
        {~r/(database)s$/i, "\\1"},
        {~r/([ti])a$/i, "\\1um"},
        {~r/((a)naly|(b)a|(d)iagno|(p)arenthe|(p)rogno|(s)ynop|(t)he)(sis|ses)$/i, "\\1sis"},
        {~r/(analy)(sis|ses)$/i, "\\1sis"},
        {~r/(octop|vir)i$/i, "\\1us"},
        {~r/(hive)s$/i, "\\1"},
        {~r/(tive)s$/i, "\\1"},
        {~r/(er)ves$/i, "\\1ve"},
        {~r/([lora])ves$/i, "\\1f"},
        {~r/([^f])ves$/i, "\\1fe"},
        {~r/([^aeiouy]|qu)ies$/i, "\\1y"},
        {~r/(m)ovies$/i, "\\1ovie"},
        {~r/(x|ch|ss|sh)es$/i, "\\1"},
        {~r/(shoe)s$/i, "\\1"},
        {~r/(o)es$/i, "\\1"},
        {~r/s$/i, ""}
      ]
  end

  defp plural_rules do
    plural_irregular_rules() ++
      [
        {~r/(child)$/i, "\\1ren"},
        {~r/(m)an$/i, "\\1en"},
        {~r/(m|l)ouse/i, "\\1ice"},
        {~r/(database)s$/i, "\\1"},
        {~r/(quiz)$/i, "\\1zes"},
        {~r/^(ox)$/i, "\\1en"},
        {~r/(matr|vert|ind)ix|ex$/i, "\\1ices"},
        {~r/(x|ch|ss|sh)$/i, "\\1es"},
        {~r/([^aeiouy]|qu)y$/i, "\\1ies"},
        {~r/(hive)$/i, "\\1s"},
        {~r/(sc[au]rf)$/i, "\\1s"},
        {~r/(?:([^f])fe|((hoo)|([lra]))f)$/i, "\\2\\1ves"},
        {~r/sis$/i, "ses"},
        {~r/([ti])um$/i, "\\1a"},
        {~r/(buffal|tomat)o$/i, "\\1oes"},
        {~r/(octop|vir)us$/i, "\\1i"},
        {~r/(bus|alias|status|canvas)$/i, "\\1es"},
        {~r/(ax|test)is$/i, "\\1es"},
        {~r/s$/i, "s"},
        {~r/data$/i, "data"},
        {~r/$/i, "s"}
      ]
  end

  def pluralize(word) when is_binary(word) do
    cond do
      Enum.member?(@uncountable, word) ->
        word

      true ->
        case Enum.find(plural_rules(), fn {regex, _replacement} ->
               Regex.match?(regex, word)
             end) do
          {regex, replacement} ->
            Regex.replace(regex, word, replacement)

          nil ->
            word <> "s"
        end
    end
  end

  def singularize(word) when is_binary(word) do
    cond do
      Enum.member?(@uncountable, word) ->
        word

      true ->
        case Enum.find(singular_rules(), fn {regex, _replacement} ->
               Regex.match?(regex, word)
             end) do
          {regex, replacement} ->
            Regex.replace(regex, word, replacement)

          nil ->
            if String.ends_with?(word, "s") do
              String.slice(word, 0..-2//1)
            else
              word
            end
        end
    end
  end
end
