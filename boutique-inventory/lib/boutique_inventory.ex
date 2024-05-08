defmodule BoutiqueInventory do
  def sort_by_price(inventory) do
    Enum.sort_by(inventory, & &1.price, :asc )
  end

  def with_missing_price(inventory) do
    inventory
    |> sort_by_price()
    |> Enum.filter(& &1.price==nil)
  end

  def update_names(inventory, old_word, new_word) do
    inventory
    |> Enum.map(fn x -> %{price: x.price, name: x.name|>String.replace(old_word,new_word),quantity_by_size: x.quantity_by_size} end)
  end

  def increase_quantity(item, count) do
    update_in(item, [:quantity_by_size], & Enum.into(&1, %{}, fn {k,v}->{k,v+count} end) )
  end

  def total_quantity(item) do
    item[:quantity_by_size]
    |> Enum.reduce(0, fn {_k,v}, acc -> acc+v end)
  end
end
