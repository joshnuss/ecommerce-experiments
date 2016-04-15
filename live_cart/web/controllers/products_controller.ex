defmodule LiveCart.ProductsController do
  use LiveCart.Web, :controller
  alias LiveCart.Catalog

  def index(conn, params) do
    page = String.to_integer(params["page"] || "1")
    {products, count} = Catalog.products(page: page)

    render conn, "index.json", %{products: products, page: page, count: count}
  end

  def show(conn, %{"id" => id}) do
    product = Catalog.find({:permalink, id})

    render conn, "show.json", %{product: product}
  end
end
