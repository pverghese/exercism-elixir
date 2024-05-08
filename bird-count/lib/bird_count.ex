defmodule BirdCount do
  def today([]) do
    nil
  end

  def today([head | _tail]) do
    head
  end

  def increment_day_count([]) do
    [1]
  end

  def increment_day_count([head | tail]) do
    [head + 1 | tail]
  end

  def has_day_without_birds?([]) do
    false
  end

  def has_day_without_birds?([head | tail]) do
    cond do
      head == 0 -> true
      true -> has_day_without_birds?(tail)
    end
  end

  def total([]) do
    0
  end

  def total([head | tail]) do
    head + total(tail)
  end

  defp busy_days_acc([], acc) do
    acc
  end

  defp busy_days_acc([head | tail], acc) do
    cond do
      head >= 5 -> busy_days_acc(tail, acc + 1)
      head < 5 -> busy_days_acc(tail, acc)
    end
  end

  def busy_days(list) do
    busy_days_acc(list, 0)
  end
end
