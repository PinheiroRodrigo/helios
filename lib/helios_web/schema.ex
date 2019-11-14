defmodule Helios.Schema do
  use Absinthe.Schema
  import_types Absinthe.Type.Custom

  alias Helios.WeatherResolver

  object :weather do
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
  end

  object :city do
    field :city_id, :integer
    field :name, :string
    field :country_code, :string
    field :weather_info, list_of(:weather)
  end

  query do

    field :get_city, non_null(:city) do
      arg :name, non_null(:id)
      arg :country_code, non_null(:id)
      resolve &WeatherResolver.get_city/2
    end

    field :get_weather_by_city, non_null(:city) do
      arg :name, non_null(:id)
      arg :country_code, non_null(:id)
      resolve &WeatherResolver.get_weather_by_city/2
    end

    field :get_weather_by_city_and_date, non_null(:city) do
      arg :name, non_null(:id)
      arg :country_code, non_null(:id)
      arg :date, non_null(:date)
      resolve &WeatherResolver.get_weather_by_city_and_date/2
    end

    field :get_weather_by_city_and_datetime, non_null(:city) do
      arg :name, non_null(:id)
      arg :country_code, non_null(:id)
      arg :date, non_null(:date)
      arg :time, non_null(:time)
      resolve &WeatherResolver.get_weather_by_city_and_datetime/2
    end

  end

  mutation do
    @desc "Add a city to track weather"
    field :track_city_weather, type: :city do
      arg :name, non_null(:string)
      arg :country_code, non_null(:string)
      resolve &Helios.WeatherResolver.track_weather_of_city/2
    end
  end

end
