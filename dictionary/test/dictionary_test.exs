defmodule DictionaryTest do
  use ExUnit.Case
  doctest Dictionary

  test "greets the world" do
    assert Kernel.is_bitstring(Dictionary.random_word())
  end
end
