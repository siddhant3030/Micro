defmodule Gorm.Stack do
  use GenServer


 #client
  def start_link(default) when is_list(default) do
    GenServer.start_link(__MODULE__, default)
  end

  def push(pid, element) do
    GenServer.cast(pid, {:push, element})
  end

  def pop(pid) do
    GenServer.call(pid, :pop)
  end

  # server
  def init(stack) do
    {:ok, stack}
  end

  def handle_call(:pop, _from, [head | tail]) do
    {:reply, head, tail}
  end

  def handle_cast({:push, element}, state) do
    {:noreply, [element | state]}
  end
end
# iex(7)> {:ok, pid} = GenServer.start_link(Stack, [:hello])
# {:ok, #PID<0.601.0>}
# iex(8)> Genserver.call(pid, :pop)
# iex(9)> GenServer.call(pid, :pop)
# :hello
# iex(10)> GenServer.cast(pid, {:push, :world})
# :ok
# iex(11)> GenServer.call(pid, :pop)
# :world

