defmodule Helios.WeatherController do
  import Ecto.Query

  alias Helios.{City, Repo}

  def track_weather_of_city(city, country_code) do
    # TODO: check if city is already tracked / maybe check if it needs an update
    with weather when is_map(weather) <- Helios.request_weather(city, country_code),
         %City{} = city <- insert_weather_report(weather)
    do
      city
    end
  end

  def insert_weather_report(weather_struct) do
    %City{}
    |> City.changeset(weather_struct)
    |> Repo.insert
  end

  def get_city(city, country_code) do
    query = from c in City,
            where: c.name == ^city and c.country_code == ^country_code,
            select: c
    Repo.one(query)
  end

  def get_weather_by_city(city, country_code) do
    query = from c in City,
            where: c.name == ^city and c.country_code == ^country_code,
            preload: [:weather_info]
    Repo.one(query)
  end

  def get_weather_by_city_and_date(city, country_code, date) do
    query = from c in City,
            where: c.name == ^city and c.country_code == ^country_code,
            join: w in assoc(c, :weather_info),
            where: w.date == ^date,
            preload: [weather_info: w]
    Repo.one(query)
  end

  def get_weather_by_city_and_datetime(city, country_code, date, time) do
    query = from c in City,
            where: c.name == ^city and c.country_code == ^country_code,
            join: w in assoc(c, :weather_info),
            where: w.date == ^date and w.time == ^time,
            preload: [weather_info: w]
    Repo.one(query)
  end

end
