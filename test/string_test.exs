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

  test "reverse" do
    assert "FooBar" == String.reverse("raBooF")
    assert "Teniszütő" == String.reverse("őtüzsineT")
    assert "❤MultiByte☆" == String.reverse("☆etyBitluM❤")
  end
end
