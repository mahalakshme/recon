ActiveAdmin.register Grade do

  menu parent: 'Organization'

  permit_params :name, :inactive

  config.sort_order = "name_asc"

end
