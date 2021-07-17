defmodule SondaMeuCredereWeb.NasaController do
  use SondaMeuCredereWeb, :controller
  alias SondaMeuCredere.Sonda

  require Logger

  # macro que retorna true ou false se condição for atendida
  defguard in_field(point) when point in 0..4

  # recebe requiição e envia para processamento e devolve resposta
  def move(conn, %{"movimentos" => movimentos}) when is_list(movimentos) do
    Enum.each(movimentos, fn x -> Sonda.move_to(x) end)

    pos = Sonda.get()

    case pos do
      %{x: x, y: y} when in_field(x) and in_field(y) ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(200, %{x: x, y: y} |> Jason.encode!())

      _ ->
        conn
        |> put_resp_content_type("application/json")
        |> send_resp(
          500,
          %{
            erro:
              "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv"
          }
          |> Jason.encode!()
        )
    end
  end

  
  def reset(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Sonda.reset() |> Jason.encode!())
  end

  def status(conn, _params) do
    conn
    |> put_resp_content_type("application/json")
    |> send_resp(200, Sonda.get() |> Jason.encode!())
  end
end
