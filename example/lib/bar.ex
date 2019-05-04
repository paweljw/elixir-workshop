defmodule Bar do
  use Application

  def start(_type, _args) do
    Bar.Supervisor.start_link(name: Bar.Supervisor)
  end
end
