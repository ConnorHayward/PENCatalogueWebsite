using Genie.Router
using BooksController

route("/") do
  serve_static_file("/welcome.html")
end

route("/hello") do
  "Welcome to Genie!"
end

route("/bgbooks", BooksController.billgatesbooks)
