defmodule SondaMeuCredere.Repo.Migrations.CreateCharts do
  use Ecto.Migration

  def change do
    create table(:charts) do
      add :labels, {:array, :string}
      add :data, {:array, :string}

      timestamps()
    end

  end
end
