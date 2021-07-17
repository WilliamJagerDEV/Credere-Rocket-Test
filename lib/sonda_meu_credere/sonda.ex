defmodule SondaMeuCredere.Sonda do
  @moduledoc """
  Módulo que armazena e manipula o estado da Sonda
  """
  use GenServer

  # Inicia processo que armazena estado da sonda
  def start_link(_init_args) do
    GenServer.start_link(__MODULE__, starter_field(), name: __MODULE__)
  end

  @impl true # implementa função init do gen server
  def init(args) do
    {:ok, args}
  end

  # função que recupera valor atual do estado da sonda
  def get do
    GenServer.call(__MODULE__, :get)
  end

  # chama função para deslocar sonda
  def move_to(step) do
    GenServer.call(__MODULE__, {:move_to, step})
  end

  # volta estado para posição inicial
  def reset do
    GenServer.call(__MODULE__, :reset)
  end

  @impl true
  def handle_call(:get, _from, state) do
    # responde com estado atual
    {:reply, state, state}
  end

  # função para deslocar sonda
  def handle_call({:move_to, "M"}, _from, %{face: face, x: x, y: y}) do
    new_state =
      case face do
        "E" -> %{face: face, x: x, y: y - 1}
        "D" -> %{face: face, x: x, y: y + 1}
        "C" -> %{face: face, x: x + 1, y: y}
        "B" -> %{face: face, x: x - 1, y: y}
      end

    {:reply, new_state, new_state}
  end

  def handle_call({:move_to, "GE"}, _from, %{face: face, x: x, y: y}) do
    new_state =
      case face do
        "E" -> %{face: "B", x: x, y: y}
        "D" -> %{face: "C", x: x, y: y}
        "C" -> %{face: "E", x: x, y: y}
        "B" -> %{face: "D", x: x, y: y}
      end

    {:reply, new_state, new_state}
  end

  def handle_call({:move_to, "GD"}, _from, %{face: face, x: x, y: y}) do
    new_state =
      case face do
        "E" -> %{face: "C", x: x, y: y}
        "D" -> %{face: "B", x: x, y: y}
        "C" -> %{face: "D", x: x, y: y}
        "B" -> %{face: "E", x: x, y: y}
      end

    {:reply, new_state, new_state}
  end

  # reseta estado
  def handle_call(:reset, _from, _state) do
    {:reply, %{sucess: true}, starter_field()}
  end

  defp starter_field, do: %{x: 0, y: 0, face: "D"}
end
