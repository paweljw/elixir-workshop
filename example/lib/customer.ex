defmodule Bar.Customer do
  @moduledoc """
  Provides the Bar with a Customer, who will keep drinking indefinitely.
  """
  use GenServer

  @doc """
  Starts the link fulfilling the GenServer spec.
  """
  def start_link(args, opts \\ []) do
    GenServer.start_link(__MODULE__, args, opts)
  end

  @doc """
  Called to initialize an instance of this GenServer.
  """
  def init([name: name]) do
    GenServer.cast(self(), :init) # Just here to show off `cast`

    state = %{name: name, drinks: 0, timer: new_ping_timer()} # Initializing the state; why do we need the timer in the state?

    {:ok, state} # An `:ok` response is necessary.
  end

  @doc """
  Handles the initial cast.
  """
  def handle_cast(:init, %{name: name} = state) do
    IO.puts "Wchodzi #{name} do baru..."
    {:noreply, state}
  end

  @doc """
  Handles ordering another drink (and remembering to get one more after that).
  """
  def handle_info(:ping, %{name: name, drinks: drinks} = state) do
    updated_timer = new_ping_timer()
    updated_drinks = drinks + 1 # Why can't we assign to drinks?

    drink = Bar.Bartender.pour_me_another

    IO.puts "[#{NaiveDateTime.utc_now}] #{name} pije #{drink} (napój numer #{updated_drinks})"

    new_state = %{state | timer: updated_timer, drinks: updated_drinks}
    {:noreply, new_state}
  end

  @doc """
  Creates a timer that will remind thn Customer to get another drink.
  """
  defp new_ping_timer() do
    Process.send_after(self(), :ping, :rand.uniform(3000) + 1000)
  end
end
