defmodule LiveCart.ProductsView do
  use LiveCart.Web, :view

  def render("index.json", %{products: products, page: page, count: count}) do
    %{
      meta: %{page: page, count: count},
      records: render_many(products, LiveCart.ProductsView, "show.json", as: :product)
    }
  end

  def render("show.json", %{product: product}) do
    product
  end
end
