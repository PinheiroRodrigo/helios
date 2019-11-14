defmodule Helios.Repo.Migrations.AddCitiesTable do
  use Ecto.Migration

  def change do
    create table(:cities) do
      add :city_id, :integer
      add :name, :string
      add :country_code, :string

      timestamps()
    end
  end
end
