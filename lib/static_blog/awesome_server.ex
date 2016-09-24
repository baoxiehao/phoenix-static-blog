defmodule StaticBlog.AwesomeServer do
  use GenServer

  def start_link do
    GenServer.start_link(__MODULE__, nil, name: __MODULE__)
  end

  def init(_args) do
    {:ok, []}
  end

  def get_by_tag(tag) do
    GenServer.call(__MODULE__, {:get_by_tag, tag})
  end

  def list do
    GenServer.call(__MODULE__, {:list})
  end

  def handle_call({:get_by_tag, tag}, _from, awesomes) do
    {
      :reply,
      awesomes |> Enum.filter(fn awesome -> Enum.member?(awesome.tags, tag) end),
      awesomes
    }
  end

  def handle_call({:list}, _from, _awesomes) do
    new_awesomes = update_awesomes
    {:reply, new_awesomes, new_awesomes}
  end

  defp update_awesomes do
    StaticBlog.Awesome.compile
  end
end
