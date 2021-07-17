defmodule SondaMeuCredereWeb.Router do
  use SondaMeuCredereWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", SondaMeuCredereWeb do
    pipe_through :api

    post "/move", NasaController, :move
    get "/reset", NasaController, :reset
    get "/status", NasaController, :status
  end
end
