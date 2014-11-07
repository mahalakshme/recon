ActiveAdmin.register Role do

  menu parent: 'Organization'

  permit_params :name, :inactive

end
