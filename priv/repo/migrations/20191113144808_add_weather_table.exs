defmodule Helios.Repo.Migrations.AddWeatherTable do
  use Ecto.Migration

  def change do
    create table(:weather) do
      add :date, :date
      add :time, :time
      add :weather, :string
      add :temperature, :float
      add :humidity, :integer
      add :cloud_percent, :integer
      add :wind_speed, :float
      add :temp_max, :float
      add :temp_min, :float
      add :rain_vol_1h, :float
      add :rain_vol_3h, :float
      add :city_id, references(:cities)

      timestamps()
    end
  end
end
