defmodule HeliosWeb.Router do
  use HeliosWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/" do
    pipe_through :api

    forward "/graphiql", Absinthe.Plug.GraphiQL,
      schema: Helios.Schema,
      interface: :simple,
      context: %{pubsub: Helios.Endpoint}
  end

end
