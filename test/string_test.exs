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

  test "reverse" do
    assert "FooBar" == String.reverse("raBooF")
    assert "Teniszütő" == String.reverse("őtüzsineT")
    assert "❤MultiByte☆" == String.reverse("☆etyBitluM❤")
  end
end
