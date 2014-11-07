ActiveAdmin.register Grade do

  menu parent: 'Organization'

  permit_params :name, :inactive

end
