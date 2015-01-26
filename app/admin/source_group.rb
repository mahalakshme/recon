ActiveAdmin.register SourceGroup do

  permit_params :id, :name

  config.sort_order = "name_asc"

end
