defmodule Fibonacci do
  @agent __MODULE__

  def start_link() do
    Agent.start_link(fn -> %{0 => 0, 1 => 1} end, name: @agent)
  end

  def calc(num, res \\ 0) do
    cond do
      num < 0 -> 0
      has_cache(num) ->
        get_cache(num)
      true ->
        res = calc(num - 1, res) + calc(num - 2, res)
        put_cache(num, res)
        res
    end
  end

  defp has_cache(num) do
    Agent.get(@agent, &Map.has_key?(&1, num))
  end

  defp get_cache(num) do
    Agent.get(@agent, &Map.get(&1, num))
  end

  defp put_cache(num, val) do
    Agent.update(@agent, &Map.put(&1, num, val))
  end
end
