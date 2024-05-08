# Use the Plot struct as it is provided
defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start(opts \\ []) do
    Agent.start(fn -> %{plots: [], count: 0} end, opts)
  end

  def list_registrations(pid) do
    Agent.get(pid,& &1.plots)
  end

  def get_id(pid) do
    state = Agent.get(pid, & &1)
    state.count
  end

  def register(pid, register_to) do
    Agent.get_and_update(pid, fn %{plots: plots, count: count} ->
      plot = %Plot{plot_id: count + 1, registered_to: register_to}
      {plot, %{plots: [plot | plots], count: count+1}}
    end)
  end

  def release(pid, plot_id) do
    Agent.update(pid, fn %{plots: p, count: c} ->
      %{plots: p |> Enum.filter(& &1.plot_id != plot_id), count: c}
    end)

  end

  def get_registration(pid, plot_id) do
    case (for p <- list_registrations(pid), p.plot_id == plot_id, do: p) do
      [] -> {:not_found, "plot is unregistered"}
      [pl] -> pl
    end

  end
end
