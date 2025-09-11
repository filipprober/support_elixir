alias Support.String

defmodule StringTest do
  use ExUnit.Case
  doctest Support.String

  test "reverse" do
    assert "FooBar" == String.reverse("raBooF")
    assert "Teniszütő" == String.reverse("őtüzsineT")
    assert "❤MultiByte☆" == String.reverse("☆etyBitluM❤")
  end
end
