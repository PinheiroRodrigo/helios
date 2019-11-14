defmodule Helios do
  @moduledoc """
  Helios keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """
  @weather_url "api.openweathermap.org/data/2.5/forecast"

  defp weather_key, do: Application.get_env(:helios, :weather_key)

  def request_weather(city, country_code) do
    city = String.capitalize(city); country_code = String.downcase(country_code)
    @weather_url <> "?q=#{city},#{country_code}&APPID=#{weather_key()}&units=metric"
    |> HTTPoison.get
    |> parse_result
  end

  defp parse_result({:ok, %{body: body, status_code: 200}}) do
    body
    |> Poison.decode!
    |> create_weather_map
  end
  defp parse_result(_), do: :error

  defp create_weather_map(map) do
    %{
      city_id: map["city"]["id"],
      name: map["city"]["name"] |> String.downcase,
      country_code: map["city"]["country"] |> String.downcase,
      weather_info: reduce_weather_info(map["list"])
    }
  end

  defp reduce_weather_info(weather_list) do
    weather_list
    |> Enum.reduce([], fn(w, acc) ->
      [date, time] = String.split(w["dt_txt"], " ")
      [
        %{
          weather: List.first(w["weather"])["description"],
          date: date |> Date.from_iso8601!,
          time: time |> Time.from_iso8601!,
          wind_speed: w["wind"]["speed"],
          humidity: w["main"]["humidity"],
          temperature: w["main"]["temp"],
          temp_min: w["main"]["temp_min"],
          temp_max: w["main"]["temp_max"],
          cloud_percent: w["clouds"]["all"],
          rain_vol_1h: w["rain"]["1h"],
          rain_vol_3h: w["rain"]["3h"]
          }
      ] ++ acc
    end)
  end

end
