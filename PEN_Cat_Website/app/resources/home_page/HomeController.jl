module HomeController
using Genie.Renderer

function home()
  html!(:home_page, :home_page)
end

end
