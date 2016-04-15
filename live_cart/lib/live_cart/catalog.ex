defmodule LiveCart.Catalog do
  use GenServer

  import LiveCart.Database, only: [run: 1]
  alias RethinkDB.Query

  @page_size 10

  def init do
    Query.table_create(:products, primary_key: :id)
    |> run
  end

  def products(options \\ []) do
    page = Keyword.get(options, :page, 1)
    from = (page - 1) * @page_size
    to = (page * @page_size)
    table = Query.table(:products)

    records = table
    |> Query.slice(from, to)
    |> run
    |> format

    count = table
    |> Query.count
    |> run

    {records, count.data}
  end

  def add(data) do
    data = Map.merge(data, %{updated_at: Query.now, created_at: Query.now})

    Query.table(:products)
    |> Query.insert(data)
    |> run
  end

  def find(id) do
    Query.table(:products)
    |> identify(id)
    |> run
    |> format
  end

  def update(id, data) do
    data = Map.put(data, :updated_at, Query.now)

    Query.table(:products)
    |> identify(id)
    |> Query.update(data)
    |> run
  end

  def delete(id) do
    Query.table(:products)
    |> identify(id)
    |> Query.delete
    |> run
  end

  defp identify(query, filters) when is_map(filters),
    do: Query.filter(query, filters) |> Query.nth(0)

  defp identify(query, {:id, id}),
    do: identify(query, %{id: id})

  defp identify(query, {:permalink, id}),
    do: identify(query, %{permalink: id})

  defp identify(query, id),
    do: identify(query, %{id: id})

  defp format(%{data: data}) when is_list(data),
    do: Enum.map(data, &format/1)

  defp format(%{data: data}),
    do: format(data)

  defp format(data) do
    Enum.map(data, &format_key_pair/1)
    |> Enum.into(%{})
  end

  defp format_key_pair({key, %RethinkDB.Pseudotypes.Time{epoch_time: epoch}}),
    do: {key, Timex.DateTime.from_seconds(epoch)}

  defp format_key_pair(pair), do: pair
end
