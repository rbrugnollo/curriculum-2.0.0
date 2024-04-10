defmodule TrafficLights.GridTest do
  use ExUnit.Case

  test "start_link should start 5 Lights with state [:green, :yellow, :red, :yellow, :green]" do
    {:ok, pid} = TrafficLights.Grid.start_link()
    assert TrafficLights.Grid.current_lights(pid) === [:green, :yellow, :red, :yellow, :green]
  end

  test "transition should transition all 5 lights" do
    {:ok, pid} = TrafficLights.Grid.start_link()
    assert TrafficLights.Grid.current_lights(pid) === [:green, :yellow, :red, :yellow, :green]

    TrafficLights.Grid.transition(pid)
    assert TrafficLights.Grid.current_lights(pid) === [:yellow, :red, :green, :red, :yellow]

    TrafficLights.Grid.transition(pid)
    assert TrafficLights.Grid.current_lights(pid) === [:red, :green, :yellow, :green, :red]

    TrafficLights.Grid.transition(pid)
    assert TrafficLights.Grid.current_lights(pid) === [:green, :yellow, :red, :yellow, :green]
  end
end
