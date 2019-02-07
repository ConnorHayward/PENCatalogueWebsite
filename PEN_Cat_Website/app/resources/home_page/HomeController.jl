module HomeController
using Genie.Renderer

cur_target = 0;

function home()
  html!(:home_page, :home_page,voltage=cur_target)
end

function set_values()
    cur_target = (@params(:pmt_voltage));
end

end
