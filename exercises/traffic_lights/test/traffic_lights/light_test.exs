defmodule TrafficLights.LightTest do
  use ExUnit.Case
  doctest TrafficLights

  test "start_link/1 should be configurable" do
    {:ok, pid} = TrafficLights.Light.start_link(:red)
    assert TrafficLights.Light.current_light(pid) === :red
  end

  test "start_link/1 should start with state :green" do
    {:ok, pid} = TrafficLights.Light.start_link()
    assert TrafficLights.Light.current_light(pid) === :green
  end

  test "transition/1 should change state from :green to :yellow, then :red and then back to :green" do
    {:ok, pid} = TrafficLights.Light.start_link()

    # Starts with :green
    assert TrafficLights.Light.current_light(pid) === :green

    # :green to :yellow
    TrafficLights.Light.transition(pid)
    assert TrafficLights.Light.current_light(pid) === :yellow

    # :yellow to :red
    TrafficLights.Light.transition(pid)
    assert TrafficLights.Light.current_light(pid) === :red

    # :red to :green
    TrafficLights.Light.transition(pid)
    assert TrafficLights.Light.current_light(pid) === :green
  end
end
