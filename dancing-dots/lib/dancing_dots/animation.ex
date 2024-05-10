defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer

  @callback init(opts) :: {:ok, opts} | {error, String.t()}
  @callback handle_frame(dot, frame_number, opts) :: dot

  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(opts), do: {:ok, opts}
      defoverridable init: 1
    end
  end
end

defmodule DancingDots.Flicker do
  use DancingDots.Animation
  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, _opts) do
    if rem(frame_number, 4) == 0, do: %{dot | opacity: dot.opacity / 2}, else: dot
  end
end

defmodule DancingDots.Zoom do
  use DancingDots.Animation

  @impl DancingDots.Animation
  def init(opts) do
    velocity = opts[:velocity]
    if !is_number(velocity) do
      {:error, "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    else
      {:ok, opts}
    end
  end

  @impl DancingDots.Animation
  def handle_frame(dot, frame_number, opts) do
    %{dot| radius: dot.radius + (frame_number - 1) * opts[:velocity]}

  end
end
