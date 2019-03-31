defmodule Procs do
  def greeter(count) do
    receive do
      {:boom, reason} ->
        exit(reason)
      {:add, n} ->
        greeter(count+n)
      msg ->
        "#{count} Hello #{msg}" |> IO.puts()
        greeter(count)
    end
  end
end
