defmodule Dictionary.WordList do
  def start(),
    do:
      "../../assets/words.txt"
      |> Path.expand(__DIR__)
      |> File.read!()

  def random_word(words),
    do:
      words
      |> String.split(~r/\n/)
      |> Enum.random()
end
