defmodule Xmlql.Model.BookStore do
  @moduledoc """
  Book store data model
  """
  require Record

  hrl_path = Path.join([__DIR__, "BookStore.hrl"])
  Record.defrecord :book_type, Record.extract(:book_type, from: hrl_path)
  Record.defrecord :book_store, Record.extract(:book_store, from: hrl_path)

  def parse_xsd() do
    {:ok, xsd} = :erlsom.compile_xsd_file(Path.join([__DIR__, "BookStore.xsd"]))
    xsd
  end

  def parse_xml(xsd) do
    {:ok, xml, _} = :erlsom.scan_file(Path.join([__DIR__, "BookStore.xml"]), xsd)

    store = book_store(xml)
    store[:book]
    |> Enum.map(fn book -> book_type(book) |> Enum.into(%{}) end)
  end

  def write_xml(books, xsd) do
    book_type_keys = Keyword.keys(book_type(book_type))
    book_types = Enum.map(
      books,
      fn book -> book_type_keys
                 |> Enum.map(&Map.get(book, &1))
                 |> List.insert_at(0, :book_type)
                 |> List.to_tuple()
      end
    )

    store = {:book_store, [], book_types}
    {:ok, xml} = :erlsom.write(store, xsd, output: :binary)

    {:ok, file} = File.open(Path.join([__DIR__, "BookStore.xml"]), [:write])
    IO.binwrite(file, xml)
    File.close(file)
  end

end
