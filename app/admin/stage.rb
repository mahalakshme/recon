ActiveAdmin.register Stage do

  permit_params :id, :name, :position, :points

  config.sort_order = "position_asc"

end
