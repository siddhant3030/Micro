defmodule ShoppingList do
  use GenServer


  #client
  def start_link() do
    GenServer.start_link(__MODULE__, [])
  end

   #Sync: Care about resopse
   #Async: Don't care about response
  def add(pid, item) do
    GenServer.cast(pid, item)
  end

  #view will invoke another callback function handle_call
  def view(pid) do
    GenServer.call(pid, :view)
  end

  def remove_item(pid, item) do
    GenServer.cast(pid, {:remove, item})
  end

  def stop(pid) do
    GenServer.stop(pid, :normal, :infinity)
  end

  #server
  #When Genserver.cast gets invoked then handle_cast callback is called
  def handle_cast({:remove_item}, list) do
    updated_list = Enum.reject(list, fn(i) -> i == item end)
    {:no_reply, updated_list}
  end

  def terminate(_reason, list) do
    IO.puts("Shopping done")
  end

  def handle_cast(item, list) do
    updated_list = [item|list]
    {:noreply, updated_list}
  end

  def handle_call(:view, _from, list) do
    {:reply, list, list}
  end

  def init(list) do
    {:ok, list}
  end


end

# Example 1

# iex(1)> {:ok, pid} = ShoppingList.start_link()
# {:ok, #PID<0.109.0>}
# iex(2)> ShoppingList.add(pid, "egg")
# :ok
# iex(3)> ShoppingList.add(pid, "egsssg")
# :ok
# iex(4)> ShoppingList.add(pid, "egssssssg")
# :ok
# iex(5)> ShoppingList.add(pid, "egssssssssssg")
# :ok
# iex(6)> ShoppingList.view(pid)
# ["egssssssssssg", "egssssssg", "egsssg", "egg"]

