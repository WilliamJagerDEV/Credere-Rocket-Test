defmodule SondaMeuCredereWeb.NasaControllerTest do
  use SondaMeuCredereWeb.ConnCase

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "move 1 - ['GE', 'M', 'M', 'M', 'GD', 'M', 'M']" do
    test "Move a sonda segundo instuções dadas", %{conn: conn} do
      # Reiniciar a posicao a cada teste
      get(conn, Routes.nasa_path(conn, :reset))

      conn =
        post(
          conn,
          Routes.nasa_path(conn, :move, movimentos: ["GE", "M", "M", "M", "GD", "M", "M"])
        )

      assert json_response(conn, 200) == %{"x" => 3, "y" => 2}
    end
  end

  describe "move 2 - ['GD', 'M', 'M']" do
    test "Move a sonda segundo instruções dadas", %{conn: conn} do
      # Reiniciar a posicao a cada teste
      get(conn, Routes.nasa_path(conn, :reset))

      conn =
        post(
          conn,
          Routes.nasa_path(conn, :move, movimentos: ["GD", "M", "M"])
        )

      assert json_response(conn, 500) == %{"erro" => "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv"}
    end
  end

  describe "wrong move - ['M', 'M', 'M', 'M', 'M', 'M']" do
    test "Retorna erro se movimento exceder o quadrante permitido", %{conn: conn} do
      # Reiniciar a posicao a cada teste
      get(conn, Routes.nasa_path(conn, :reset))

      conn =
        post(
          conn,
          Routes.nasa_path(conn, :move, movimentos: ["M", "M", "M", "M", "M", "M"])
        )

      assert json_response(conn, 500) == %{"erro" => "Um movimento inválido foi detectado, infelizmente a sonda ainda não possui a habilidade de #vvv"}
    end
  end

  describe "reset" do
    test "Volta sonda da NASA para sua posição inicial", %{conn: conn} do
      conn = get(conn, Routes.nasa_path(conn, :reset))
      assert json_response(conn, 200) == %{"sucess" => true}
    end
  end

  describe "status" do
    test "Mostra posição e direção atual da sonda da NASA", %{conn: conn} do
      # Reiniciar a posicao a cada teste
      get(conn, Routes.nasa_path(conn, :reset))
      conn = get(conn, Routes.nasa_path(conn, :status))
      assert json_response(conn, 200) == %{"face" => "D", "x" => 0, "y" => 0}
    end
  end
end
