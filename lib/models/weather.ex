defmodule Helios.Weather do
  use Ecto.Schema
  import Ecto.Changeset

  schema "weather" do
    field :date, :date
    field :time, :time
    field :weather, :string
    field :temperature, :float
    field :humidity, :integer
    field :cloud_percent, :integer
    field :wind_speed, :float
    field :temp_max, :float
    field :temp_min, :float
    field :rain_vol_1h, :float
    field :rain_vol_3h, :float
    belongs_to :city, Helios.City

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:date, :time, :weather, :temperature, :humidity, :cloud_percent, :wind_speed, :temp_max, :temp_min, :rain_vol_1h, :rain_vol_3h])
    |> validate_required([:date, :time, :weather, :temperature, :humidity])
  end
end
