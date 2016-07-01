# Experiments

## RethinkDB

- Use RethinkDB as backend store
  - NoSQL provides easy to customize models (e.g. easily add attributes to Product model)
  - Changefeeds will provide realtime interactions with the browser

## Web Sockets

- Cart data would not need to be constantly fetched with each request and can be synced across browsers
- Stock levels and product availability changes can be pushed to the browser, and many types of product data can be cached in client side storage. Imagine a product just sold out, everyone viewing the product is notified. Customers with the product in their cart are notified. Customers can also be notified when an item in their cart is about to sell out (i.e Hurry! XYZ item is about to sell out.)
- Checkout progress: when each step in the checkout completes, the client is notified so they get a progress bar (i.e. verify order, process payment, update db, send email notification)
- Streaming aggregates/analytics

## Collaborative editing

- Edit product data with live layout
- See what each admin is editing
- Revision tracking with draft/publish support

## Parallel execution

- Cart page: Retrieve multiple shipping rates, tax rates and stock lookup at the same time and get a 300%+ boost in performance for the cart page.
- Checkout process:
      pre-checkout: Retrieve shipping rates & tax rates in parallel
      post-checkout: Update various subsystems in parallel
- Product page: No need to load cart data (use push instead of pull), load product data in parallel with stock lookup, would get a 300% boost in response time.

## Geo Location

- Determine shipping rates and tax rates using lat/long conversion

## 3D UI

- UI that works with 3D TVs and 3D headsets

## Push-Pull Abstraction

- Push: sockets, webhooks, emails
- Pull: api
