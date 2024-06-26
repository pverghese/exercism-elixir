defmodule BasketballWebsite do
  def extract_from_path(data, path) do
    do_extract(data, String.split(path, "."))
  end
  def do_extract(data, []), do: data
  def do_extract(data,[h|tail]) do
    do_extract(data[h], tail)
  end

  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end
