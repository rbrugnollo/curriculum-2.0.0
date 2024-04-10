defmodule Stack do
  use GenServer

  # Client
  def start_link(initial_state \\ []) do
    GenServer.start_link(__MODULE__, initial_state, [])
  end

  def push(stack_pid, elements) do
    GenServer.cast(stack_pid, {:push, elements})
  end

  def pop(stack_pid, take \\ 1) do
    GenServer.call(stack_pid, {:pop, take})
  end

  # Server
  @impl true
  def init(initial_state) do
    {:ok, initial_state}
  end

  @impl true
  def handle_cast({:push, elements}, state) do
    {:noreply, elements ++ state}
  end

  @impl true
  def handle_call({:pop, take}, _from, state) do
    {:reply, Enum.take(state, take), Enum.drop(state, take)}
  end
end
