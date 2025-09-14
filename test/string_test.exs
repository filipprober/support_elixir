alias Support.String

defmodule StringTest do
  use ExUnit.Case, async: true

  doctest Support.String

  test "after/2" do
    assert "nah" == String.after("hannah", "han")
    assert "nah" == String.after("hannah", "n")
    assert "nah" == String.after("ééé hannah", "han")
    assert "hannah" == String.after("hannah", "xxxx")
    assert "hannah" == String.after("hannah", "")
    assert "nah" == String.after("han0nah", "0")
    assert "nah" == String.after("han0nah", 0)
    assert "nah" == String.after("han2nah", 2)
  end

  test "after_last/2" do
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

  test "before/2" do
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

  test "before_last/2" do
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

  test "between/3" do
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

  test "between_first/3" do
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

  test "kebab/1" do
    assert "support-package" == String.kebab("SupportPackage")
    assert "support-package" == String.kebab("Support Package")
    assert "support❤-package" == String.kebab("Support ❤ Package")
    assert "" == String.kebab("")
  end

  test "lcfirst/1" do
    assert "" == String.lcfirst("")
    assert "support" == String.lcfirst("Support")
    assert "elixir support" == String.lcfirst("Elixir support")
    assert "мама" == String.lcfirst("Мама")
    assert "мама мыла раму" == String.lcfirst("Мама мыла раму")
  end

  test "lower/1" do
    assert "foo bar baz" == String.lower("FOO BAR BAZ")
    assert "foo bar baz" == String.lower("foO bAr BaZ")
  end

  test "plural/1" do
    assert "cats" == String.plural("cat")
    assert "Dogs" == String.plural("Dog")
    assert "Tomatoes" == String.plural("Tomato")
    assert "UserGroups" == String.plural("UserGroup")
    assert "ProductCategories" == String.plural("ProductCategory")
  end

  test "plural/2" do
    assert "cat" == String.plural("cat", 1)
    assert "Dog" == String.plural("Dog", 1)
    assert "Tomato" == String.plural("Tomato", 1)
    assert "UserGroup" == String.plural("UserGroup", 1)
    assert "ProductCategory" == String.plural("ProductCategory", 1)

    assert "cats" == String.plural("cat", -1)
    assert "Dogs" == String.plural("Dog", -1)
    assert "Tomatoes" == String.plural("Tomato", -1)
    assert "UserGroups" == String.plural("UserGroup", -1)
    assert "ProductCategories" == String.plural("ProductCategory", -1)
  end

  test "reverse/1" do
    assert "FooBar" == String.reverse("raBooF")
    assert "Teniszütő" == String.reverse("őtüzsineT")
    assert "❤MultiByte☆" == String.reverse("☆etyBitluM❤")
  end

  test "singular/1" do
    assert "cat" == String.singular("cats")
    assert "Dog" == String.singular("Dogs")
    assert "Tomato" == String.singular("Tomatoes")
    assert "UserGroup" == String.singular("UserGroups")
    assert "ProductCategory" == String.singular("ProductCategories")
  end

  test "snake/1" do
    assert "e_l_i_x_i_r_package" == String.snake("ELIXIRPackage")
    assert "elixir_framework" == String.snake("ElixirFramework")
    assert "elixir_framework" == String.snake("Elixir   Framework")

    assert "foo-bar" == String.snake("foo-bar")
    assert "foo-_bar" == String.snake("Foo-Bar")
    assert "foo__bar" == String.snake("Foo_Bar")
    assert "żółtałódka" == String.snake("ŻółtaŁódka")
  end

  test "snake/2" do
    assert "elixir package" == String.snake("ElixirPackage", " ")
  end

  test "studly/1" do
    assert "ElixirSUPPORTLibrary" == String.studly("elixir_s_u_p_p_o_r_t_library")
    assert "ElixirSupportLibrary" == String.studly("elixir_support_library")
    assert "ElixirSupportLibrary" == String.studly("elixir-support-library")
    assert "ElixirSupportLibrary" == String.studly("elixir  -_-  support  -_-  library  ")

    assert "FooBar" == String.studly("fooBar")
    assert "FooBar" == String.studly("foo_bar")
    assert "FooBarBaz" == String.studly("foo-barBaz")
    assert "FooBarBaz" == String.studly("foo-bar_baz")

    assert "ÖffentlicheÜberraschungen" == String.studly("öffentliche-überraschungen")
  end

  test "take/2" do
    assert "ab" == String.take("abcdef", 2)
    assert "ef" == String.take("abcdef", -2)
    assert "" == String.take("abcdef", 0)
    assert "" == String.take("", 2)
    assert "abcdef" == String.take("abcdef", 10)
    assert "ü" == String.take("üöä", 1)
  end

  describe "to_case/2" do
    test "kebab" do
      assert "support-package" == String.to_case("SupportPackage", :kebab)
      assert "support-package" == String.to_case("Support Package", :kebab)
      assert "support❤-package" == String.to_case("Support ❤ Package", :kebab)
      assert "" == String.to_case("", :kebab)
    end

    test "snake" do
      assert "e_l_i_x_i_r_package" == String.to_case("ELIXIRPackage", :snake)
      assert "elixir_framework" == String.to_case("ElixirFramework", :snake)
      assert "elixir_framework" == String.to_case("Elixir   Framework", :snake)

      assert "foo-bar" == String.to_case("foo-bar", :snake)
      assert "foo-_bar" == String.to_case("Foo-Bar", :snake)
      assert "foo__bar" == String.to_case("Foo_Bar", :snake)
      assert "żółtałódka" == String.to_case("ŻółtaŁódka", :snake)
    end

    test "upper" do
      assert "FOO BAR BAZ" == String.to_case("foo bar baz", :upper)
      assert "FOO BAR BAZ" == String.to_case("foO bAr BaZ", :upper)
    end

    test "lower" do
      assert "foo bar baz" == String.to_case("FOO BAR BAZ", :lower)
      assert "foo bar baz" == String.to_case("foO bAr BaZ", :lower)
    end
  end

  describe "to_case/3" do
    test "snake" do
      assert "elixir package" == String.to_case("ElixirPackage", " ", :snake)
    end
  end

  test "ucfirst/1" do
    assert "" == String.ucfirst("")
    assert "Support" == String.ucfirst("support")
    assert "Elixir support" == String.ucfirst("elixir support")
    assert "Мама" == String.ucfirst("мама")
    assert "Мама мыла раму" == String.ucfirst("мама мыла раму")
  end

  test "upper/1" do
    assert "FOO BAR BAZ" == String.upper("foo bar baz")
    assert "FOO BAR BAZ" == String.upper("foO bAr BaZ")
  end
end
