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

  @impl true
  def handle_call({:filter, filters}, _from, state) do
    {
      :reply,
      Enum.filter(
        state,
        fn book ->
          Enum.reduce(
            Map.to_list(filters),
            true,
            fn
              _, false -> false
              {name, match}, _ -> String.contains?(to_string(Map.get(book, name, "")), match)
            end
          )
        end
      ),
      state
    }
  end

  def list() do
    GenServer.call(__MODULE__, :list)
  end

  def filter(filters) do
    GenServer.call(__MODULE__, {:filter, filters})
  end

end
