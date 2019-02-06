using Genie.Router
using BooksController
using HomeController

route("/",HomeController.home)

# route("/") do
#   serve_static_file("/welcome.html")
# end

route("/hello") do
  "Welcome to Genie!"
end

route("/bgbooks", BooksController.billgatesbooks)
