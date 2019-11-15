defmodule Helios.City do
  use Ecto.Schema
  import Ecto.Changeset

  schema "cities" do
    field :city_id, :integer
    field :name, :string
    field :country_code, :string
    has_many :weather_info, Helios.Weather, on_replace: :delete

    timestamps()
  end

  @doc false
  def changeset(struct, attrs) do
    struct
    |> cast(attrs, [:city_id, :name, :country_code])
    |> cast_assoc(:weather_info, with: &Helios.Weather.changeset/2)
    |> validate_required([:city_id, :name, :country_code])
  end
end
