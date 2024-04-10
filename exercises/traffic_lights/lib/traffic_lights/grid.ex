defmodule TrafficLights.Grid do
  @moduledoc """
    GenServer that manages five TrafficLights.Light processes
  """

  use GenServer

  @doc """
  Initialize Grid
  """
  @spec start_link([TrafficLights.Light.light_color()] | nil) :: GenServer.on_start()
  def start_link(initial_lights \\ [:green, :yellow, :red, :yellow, :green]) do
    GenServer.start_link(__MODULE__, initial_lights, [])
  end

  @doc """
  Return current Lights
  """
  @spec current_lights(pid()) :: [TrafficLights.Light.light_color()]
  def current_lights(pid) do
    GenServer.call(pid, :current_lights)
  end

  @doc """
  Transition All Traffic Lights
  """
  @spec transition(pid()) :: :ok
  def transition(pid) do
    GenServer.cast(pid, :transition)
  end

  # Server
  @impl true
  def init(initial_lights) do
    pids =
      Enum.map(initial_lights, fn light ->
        {:ok, pid} = TrafficLights.Light.start_link(light)
        pid
      end)

    {:ok, pids}
  end

  @impl true
  def handle_call(:current_lights, _from, state) do
    lights = Enum.map(state, &TrafficLights.Light.current_light/1)
    {:reply, lights, state}
  end

  @impl true
  def handle_cast(:transition, state) do
    Enum.each(state, &TrafficLights.Light.transition/1)
    {:noreply, state}
  end
end
