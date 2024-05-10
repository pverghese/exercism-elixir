defmodule TopSecret do
  def to_ast(string) do
    # Please implement the to_ast/1 function
    Code.string_to_quoted!(string)
  end

  def decode_secret_message_part({op, _, args} = ast, acc) when op in [:def, :defp] do
    {name, arg} = get_function_name(args)
    {ast, [String.slice(name, 0, length(arg)) | acc]}
  end

  def decode_secret_message_part(ast, acc) do
    {ast, acc}
  end

  def get_function_name(args) do
    case args do
      [{:when, _, args} | _ ] -> get_function_name(args)
      [{name, _, args} | _ ] when is_list(args) -> {to_string(name), args}
      [{name, _, args} | _] when is_atom(args) -> {to_string(name), []}
    end
  end

  def decode_secret_message(string) do
    ast = to_ast(string)
    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)

    acc
    |> Enum.reverse()
    |> Enum.join("")
  end
end
