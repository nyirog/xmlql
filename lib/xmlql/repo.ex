defmodule Xmlql.Repo do
  use GenServer

  def start_link([]) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end
  
  @impl true
  def init(:ok) do
    {:ok, Xmlql.Model.BookStore.parse_xml()}
  end

  @impl true
  def handle_call(:list, _from, state) do
    {:reply, state, state}
  end

  def list() do
    GenServer.call(__MODULE__, :list)
  end
end
