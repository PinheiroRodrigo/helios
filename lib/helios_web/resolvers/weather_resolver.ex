defmodule Helios.WeatherResolver do
  alias Helios.{WeatherController, City}

  def track_weather_of_city(%{name: city, country_code: cc}, _info) do
    case WeatherController.track_weather_of_city(city, cc) do
      {:ok, city} -> {:ok, city}
      _ -> {:error, "City not found"}
    end
  end

  def get_city(%{name: city, country_code: cc}, _info) do
    case WeatherController.get_city(city, cc) do
      %City{} = city -> {:ok, city}
      _ -> {:error, "City not found"}
    end
  end

  def get_weather_by_city(%{name: city, country_code: cc}, _info) do
    case WeatherController.get_weather_by_city(city, cc) do
      %City{} = city -> {:ok, city}
      _ -> {:error, "City not found"}
    end
  end

  def get_weather_by_city_and_date(%{name: city, country_code: cc, date: date}, _info) do
    case WeatherController.get_weather_by_city_and_date(city, cc, date) do
      %City{} = city -> {:ok, city}
      _ -> {:error, "City not found"}
    end
  end

  def get_weather_by_city_and_datetime(%{name: city, country_code: cc, date: date, time: time}, _info) do
    case WeatherController.get_weather_by_city_and_datetime(city, cc, date, time) do
      %City{weather_info: []} -> {:error, "no forecast for this specific day/time"}
      %City{} = city -> {:ok, city}
      _ -> {:error, "City not found"}
    end
  end

end
