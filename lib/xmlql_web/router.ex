defmodule XmlqlWeb.Router do
  use XmlqlWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/api", Absinthe.Plug,
      schema: XmlqlWeb.Schema

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: XmlqlWeb.Schema,
      interface: :simple,
      socket: XmlqlWeb.UserSocket
  end

end
