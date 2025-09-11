alias Support.String

defmodule StringTest do
  use ExUnit.Case, async: true

  doctest Support.String

  test "after" do
    assert "nah" == String.after("hannah", "han")
    assert "nah" == String.after("hannah", "n")
    assert "nah" == String.after("ééé hannah", "han")
    assert "hannah" == String.after("hannah", "xxxx")
    assert "hannah" == String.after("hannah", "")
    assert "nah" == String.after("han0nah", "0")
    assert "nah" == String.after("han0nah", 0)
    assert "nah" == String.after("han2nah", 2)
  end

  test "after_last" do
    assert "tte" == String.after_last("yvette", "yve")
    assert "e" == String.after_last("yvette", "t")
    assert "e" == String.after_last("ééé yvette", "t")
    assert "" == String.after_last("yvette", "tte")
    assert "yvette" == String.after_last("yvette", "xxxx")
    assert "yvette" == String.after_last("yvette", "")
    assert "te" == String.after_last("yv0et0te", "0")
    assert "te" == String.after_last("yv0et0te", 0)
    assert "te" == String.after_last("yv2et2te", 2)
    assert "foo" == String.after_last("----foo", "---")
  end

  test "before" do
    assert "han" == String.before("hannah", "nah")
    assert "ha" == String.before("hannah", "n")
    assert "ééé" == String.before("ééé", "han")
    assert "hannah" == String.before("hannah", "xxxx")
    assert "hannah" == String.before("hannah", "")
    assert "han" == String.before("han0nah", "0")
    assert "han" == String.before("han0nah", 0)
    assert "han" == String.before("han2nah", 2)
    assert "" == String.before("", "")
    assert "" == String.before("a", "a")
    assert "" == String.before("a", "a")
    assert "foo" == String.before("foo@bar.com", "@")
    assert "foo" == String.before("foo@@bar.com", "@")
    assert "" == String.before("@foo@bar.com", "@")
  end

  test "before_last" do
    assert "yve" == String.before_last("yvette", "tte")
    assert "yvet" == String.before_last("yvette", "t")
    assert "ééé " == String.before_last("ééé yvette", "yve")
    assert "" == String.before_last("yvette", "yve")
    assert "yvette" == String.before_last("yvette", "xxxx")
    assert "yvette" == String.before_last("yvette", "")
    assert "yv0et" == String.before_last("yv0et0te", "0")
    assert "yv0et" == String.before_last("yv0et0te", 0)
    assert "yv2et" == String.before_last("yv2et2te", 2)
    assert "" == String.before_last("", "test")
    assert "" == String.before_last("yvette", "yvette")
    assert "support" == String.before_last("support package", " ")
    assert "yvette" == String.before_last("yvette\tyv0et0te", "\t")
  end

  test "between" do
    assert "abc" == String.between("abc", "", "c")
    assert "abc" == String.between("abc", "a", "")
    assert "abc" == String.between("abc", "", "")
    assert "b" == String.between("abc", "a", "c")
    assert "b" == String.between("dddabc", "a", "c")
    assert "b" == String.between("abcddd", "a", "c")
    assert "b" == String.between("dddabcddd", "a", "c")
    assert "nn" == String.between("hannah", "ha", "ah")
    assert "a]ab[b" == String.between("[a]ab[b]", "[", "]")
    assert "foo" == String.between("foofoobar", "foo", "bar")
    assert "bar" == String.between("foobarbar", "foo", "bar")
    assert "234" == String.between("12345", 1, 5)
    assert "45" == String.between("123456789", "123", "6789")
    assert "nothing" == String.between("nothing", "foo", "bar")
  end

  test "between_first" do
    assert "abc" == String.between_first("abc", "", "c")
    assert "abc" == String.between_first("abc", "a", "")
    assert "abc" == String.between_first("abc", "", "")
    assert "b" == String.between_first("abc", "a", "c")
    assert "b" == String.between_first("dddabc", "a", "c")
    assert "b" == String.between_first("abcddd", "a", "c")
    assert "b" == String.between_first("dddabcddd", "a", "c")
    assert "nn" == String.between_first("hannah", "ha", "ah")
    assert "a" == String.between_first("[a]ab[b]", "[", "]")
    assert "foo" == String.between_first("foofoobar", "foo", "bar")
    assert "" == String.between_first("foobarbar", "foo", "bar")
  end

  test "kebab" do
    assert "support-package" == String.kebab("SupportPackage")
    assert "support-package" == String.kebab("Support Package")
    assert "support❤-package" == String.kebab("Support ❤ Package")
    assert "" == String.kebab("")
  end

  test "lcfirst" do
    assert "" == String.lcfirst("")
    assert "support" == String.lcfirst("Support")
    assert "elixir support" == String.lcfirst("Elixir support")
    assert "мама" == String.lcfirst("Мама")
    assert "мама мыла раму" == String.lcfirst("Мама мыла раму")
  end

  test "lower" do
    assert "foo bar baz" == String.lower("FOO BAR BAZ")
    assert "foo bar baz" == String.lower("foO bAr BaZ")
  end

  test "reverse" do
    assert "FooBar" == String.reverse("raBooF")
    assert "Teniszütő" == String.reverse("őtüzsineT")
    assert "❤MultiByte☆" == String.reverse("☆etyBitluM❤")
  end

  test "snake" do
    assert "e_l_i_x_i_r_package" == String.snake("ELIXIRPackage")
    assert "elixir_framework" == String.snake("ElixirFramework")
    assert "elixir package" == String.snake("ElixirPackage", " ")
    assert "elixir_framework" == String.snake("Elixir   Framework")

    assert "foo-bar" == String.snake("foo-bar")
    assert "foo-_bar" == String.snake("Foo-Bar")
    assert "foo__bar" == String.snake("Foo_Bar")
    assert "żółtałódka" == String.snake("ŻółtaŁódka")
  end

  test "take" do
    assert "ab" == String.take("abcdef", 2)
    assert "ef" == String.take("abcdef", -2)
    assert "" == String.take("abcdef", 0)
    assert "" == String.take("", 2)
    assert "abcdef" == String.take("abcdef", 10)
    assert "ü" == String.take("üöä", 1)
  end

  test "ucfirst" do
    assert "" == String.ucfirst("")
    assert "Support" == String.ucfirst("support")
    assert "Elixir support" == String.ucfirst("elixir support")
    assert "Мама" == String.ucfirst("мама")
    assert "Мама мыла раму" == String.ucfirst("мама мыла раму")
  end

  test "upper" do
    assert "FOO BAR BAZ" == String.upper("foo bar baz")
    assert "FOO BAR BAZ" == String.upper("foO bAr BaZ")
  end
end
