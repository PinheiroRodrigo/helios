defmodule WeatherPolling do
  use GenServer
  @timeout 60 * 60 * 1000 # 1 hour

  def start_link() do
    GenServer.start_link(__MODULE__, %{})
  end

  def init(state) do
    schedule_polling()
    {:ok, state}
  end

  def handle_info(:work, state) do
    # get 50 most searched cities
    # insert_or_update on DB
    # do important stuff
    schedule_polling()
    {:noreply, state}
  end

  defp schedule_polling(), do: Process.send_after(self(), :work, @timeout)

end
