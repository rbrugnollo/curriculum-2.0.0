defmodule TrafficLights.Light do
  @moduledoc """
    This module uses a GenServer in order to manage a single
    Traffic Light and its transitions
  """

  @type light_color :: :green | :yellow | :red

  use GenServer

  # Client

  @doc """
  Startup a GenServer and return the pid
  """
  @spec start_link(light_color() | nil) :: GenServer.on_start()
  def start_link(initial_state \\ :green) do
    GenServer.start_link(__MODULE__, initial_state, [])
  end

  @doc """
  Transition Light from :green -> :yellow -> :red
  """
  @spec transition(pid()) :: :ok
  def transition(pid) do
    GenServer.cast(pid, :transition)
  end

  @doc """
  Return current light color
  """
  @spec current_light(pid()) :: light_color()
  def current_light(pid) do
    GenServer.call(pid, :current_light)
  end

  # Server

  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_cast(:transition, state) do
    color =
      case state do
        :green -> :yellow
        :yellow -> :red
        _ -> :green
      end

    {:noreply, color}
  end

  @impl true
  def handle_call(:current_light, _from, state) do
    {:reply, state, state}
  end
end
