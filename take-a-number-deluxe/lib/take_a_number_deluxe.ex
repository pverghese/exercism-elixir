defmodule TakeANumberDeluxe do
  # Client API
  use GenServer

  @spec start_link(keyword()) :: {:ok, pid()} | {:error, atom()}
  def start_link(arg) do
    GenServer.start_link(__MODULE__, arg)
  end

  @spec report_state(pid()) :: TakeANumberDeluxe.State.t()
  def report_state(machine) do
    GenServer.call(machine, :report)
  end

  @spec queue_new_number(pid()) :: {:ok, integer()} | {:error, atom()}
  def queue_new_number(machine) do
    GenServer.call(machine, :new)
  end

  @spec serve_next_queued_number(pid(), integer() | nil) :: {:ok, integer()} | {:error, atom()}
  def serve_next_queued_number(machine, priority_number \\ nil) do
    # Please implement the serve_next_queued_number/2 function
    GenServer.call(machine, {:serve_next_queued_number, priority_number})
  end

  @spec reset_state(pid()) :: :ok
  def reset_state(machine) do
    GenServer.cast(machine, :reset_state)
  end

  # Server callbacks

  # Please implement the necessary callbacks
  @impl true
  def init(arg) do
    with shutdown <- Keyword.get(arg, :auto_shutdown_timeout, :infinity),
         {:ok, state} <- TakeANumberDeluxe.State.new(arg[:min_number], arg[:max_number], shutdown) do
      {:ok, state, shutdown}
    else
      _ -> {:stop, :invalid_configuration}
    end
  end

  @impl true
  def handle_call(:report, _from, state) do
    {:reply, state, state, state.auto_shutdown_timeout}
  end

  @impl true
  def handle_call(:new, _from, state) do
    num = TakeANumberDeluxe.State.queue_new_number(state)

    case num do
      {:ok, new_number, new_state} ->
        {:reply, {:ok, new_number}, new_state, state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl true
  def handle_call({:serve_next_queued_number, priority_number}, _from, state) do
    case TakeANumberDeluxe.State.serve_next_queued_number(state, priority_number) do
      {:ok, next_number, new_state} ->
        {:reply, {:ok, next_number}, new_state, state.auto_shutdown_timeout}

      error ->
        {:reply, error, state, state.auto_shutdown_timeout}
    end
  end

  @impl GenServer
  def handle_cast(:reset_state, state) do
    {:noreply, %TakeANumberDeluxe.State{state | queue: TakeANumberDeluxe.Queue.new()},
     state.auto_shutdown_timeout}
  end
  @impl GenServer
  def handle_info(:timeout, _state) do
    exit(:normal)
  end
  @impl GenServer
  def handle_info(_, state) do
    {:noreply, state, state.auto_shutdown_timeout}
  end
end
