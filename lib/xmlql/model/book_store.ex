defmodule Xmlql.Model.BookStore do
  @moduledoc """
  Book store data model
  """
  require Record

  hrl_path = Path.join([__DIR__, "BookStore.hrl"])
  Record.defrecord :book_type, Record.extract(:book_type, from: hrl_path)
  Record.defrecord :book_store, Record.extract(:book_store, from: hrl_path)

  def parse_xml() do
    {:ok, xsd} = :erlsom.compile_xsd_file(Path.join([__DIR__, "BookStore.xsd"]))
    {:ok, xml, _} = :erlsom.scan_file(Path.join([__DIR__, "BookStore.xml"]), xsd)
    xml
  end
end
