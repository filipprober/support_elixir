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
