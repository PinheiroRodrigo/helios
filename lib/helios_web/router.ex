defmodule HeliosWeb.Router do
  use HeliosWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HeliosWeb do
    pipe_through :api
  end
end
