defmodule Helios.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :city_id, :integer
    field :name, :string
    field :country_code, :string
    has_many :weather_info, Helios.Weather

    timestamps()
  end

  @doc false
  def changeset(message, attrs) do
    message
    |> cast(attrs, [:city_id, :name, :country_code])
    |> cast_assoc(:weather_info, with: &Helios.Weather.changeset/2)
    |> validate_required([:city_id, :name, :country_code])
  end
end
