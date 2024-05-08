defmodule Darts do
  @type position :: {number, number}

  @doc """
  Calculate the score of a single dart hitting a target
  """
  @spec score(position) :: integer
  def score({x, y}) do
    distance = ((x)**2 + (y)**2)**0.5
    cond do
      distance > 10 -> 0
      distance > 5  -> 1
      distance > 1  -> 5
      distance <= 1 -> 10
    end
  end
end
