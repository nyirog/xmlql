defmodule Xmlql.Repo do
  use GenServer

  alias Xmlql.Model.BookStore

  def start_link([]) do
    GenServer.start_link(__MODULE__, :ok, name: __MODULE__)
  end
  
  @impl true
  def init(:ok) do
    xsd = BookStore.parse_xsd()
    xml = BookStore.parse_xml(xsd)
    {:ok, %{xml: xml, xsd: xsd}}
  end

  @impl true
  def handle_call(:list, _from, %{xml: books} = state) do
    {:reply, books, state}
  end

  @impl true
  def handle_call({:filter, filters}, _from, %{xml: books} = state) do
    {
      :reply,
      Enum.filter(
        books,
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

  def handle_call({:create, book}, _from, %{xml: books} = state) do
    normalized_book = BookStore.normalize_book(book)
    {:reply, normalized_book, Map.put(state, :xml, [normalized_book|books])}
  end

  def list() do
    GenServer.call(__MODULE__, :list)
  end

  def filter(filters) do
    GenServer.call(__MODULE__, {:filter, filters})
  end

  def create(book) do
    GenServer.call(__MODULE__, {:create, book})
  end

end
