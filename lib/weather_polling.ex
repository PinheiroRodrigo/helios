defmodule Helios.WeatherPolling do
  use GenServer
  @timeout 60 * 60 * 1000 # 1 hour

  import Ecto.Query
  alias Helios.{Repo, City}

  def start_link(_default) do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_polling()
    {:ok, state}
  end

  def handle_info(:work, state) do
    update_weather_info()
    schedule_polling()
    {:noreply, state}
  end

  defp schedule_polling(), do: Process.send_after(self(), :work, @timeout)

  defp update_weather_info() do
    Repo.all(from c in City, join: w in assoc(c, :weather_info), preload: [weather_info: w])
    |> Enum.each(fn city ->
      weather_changes = Helios.request_weather(city.name, city.country_code)
      City.changeset(city, weather_changes)
      |> Repo.update
    end)
  end

end
