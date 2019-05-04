defmodule Bar.Supervisor do
  @moduledoc """
  Supervision module for the Bar.
  """
  use Supervisor

  @doc """
  Fulfills the Supervisor spec establishing the link to itself
  """
  def start_link(opts \\ []) do
    Supervisor.start_link(__MODULE__, :ok, opts)
  end

  @doc """
  When the supervisor initializes, it will bring it's supervision tree online.
  """
  def init(:ok) do
    children = [
      Supervisor.child_spec({Bar.Customer, name: "Jan Kowalski"}, id: :jan_kowalski), # We need to give IDs by hand, since otherwise
      Supervisor.child_spec({Bar.Customer, name: "Stefan Nowak"}, id: :stefan_nowak), # child specs for the same module would be identical,
      Supervisor.child_spec({Bar.Customer, name: "José Valim"}, id: :jose_valim),     # and we can't have multiple children with same specs.
    ]

    Supervisor.init(children, strategy: :one_for_one) # Simple one_for_one strategy - if a child dies, it'll be brought up
  end
end
