ActiveAdmin.register Source do

  permit_params :id, :name, :source_group_id

  config.sort_order = "name_asc"

end
