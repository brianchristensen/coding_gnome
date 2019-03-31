defmodule Talker do
  def say(sentence_list) do
    for sentence <- sentence_list, do: System.cmd("say", [sentence])
  end
end
