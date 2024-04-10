defmodule StackTest do
  use ExUnit.Case
  doctest Stack

  test "start_link/1 - default state" do
    {:ok, pid} = Stack.start_link()
    assert Stack.pop(pid) === []
  end

  test "pop/1 - remove one element from stack" do
    {:ok, pid} = Stack.start_link([1, 2, 3, 4, 5])
    assert Stack.pop(pid) === [1]
  end

  test "pop/1 - remove multiple elements from stack" do
    {:ok, pid} = Stack.start_link([1, 2, 3, 4, 5])
    assert Stack.pop(pid, 3) === [1, 2, 3]
  end

  test "pop/1 - remove element from empty stack" do
    {:ok, pid} = Stack.start_link([])
    assert Stack.pop(pid) === []
  end

  test "push/2 - add element to empty stack" do
    {:ok, pid} = Stack.start_link([])
    Stack.push(pid, [1])
    assert Stack.pop(pid) === [1]
  end

  test "push/2 - add element to stack with multiple elements" do
    {:ok, pid} = Stack.start_link([1, 2, 3, 4, 5])
    Stack.push(pid, [10, 12])
    assert Stack.pop(pid, 10) === [10, 12, 1, 2, 3, 4, 5]
  end
end
