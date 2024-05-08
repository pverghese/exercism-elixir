defmodule RPNCalculator.Exception do
  # Please implement DivisionByZeroError here.
  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"
    @impl true
    def exception(value) do
      case value do
        [] ->
          %StackUnderflowError{}

        _ ->
          %StackUnderflowError{message: "stack underflow occurred, " <> "context: " <> value}
      end
    end
  end

  def divide([a,b]) when (a > 0 and b > 0) do
    b/a
  end
  def divide([0, _]) , do: (raise DivisionByZeroError)
  def divide([_]) , do: (raise StackUnderflowError, "when dividing")
  def divide([]), do: (raise StackUnderflowError, "when dividing")

end
