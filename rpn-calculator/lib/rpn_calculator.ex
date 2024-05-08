defmodule RPNCalculator do
  def calculate!(stack, operation) do
    operation.(stack)

  end

  def calculate(stack, operation) do
    try do
      a = operation.(stack)
      {:ok, a}
    rescue
      _ -> :error
    end

  end

  def calculate_verbose(stack, operation) do
    try do
      a = operation.(stack)
      {:ok, a}
    rescue
      e -> {:error, e.message}
    end
  end
end
