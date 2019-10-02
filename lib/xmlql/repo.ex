defmodule Xmlql.Repo do
  use GenServer

  def start_link(opts) do
    GenServer.start_link(__MODULE__, :ok, opts)
  end
  
  @impl true
  def init(:ok) do
    {:ok, %{}}
  end

  @impl true
  def handle_call(_, _, state) do
    {:reply, state, state}
  end

  @impl true
  def handle_cast(_, state) do
    {:noreply, state}
  end
end
