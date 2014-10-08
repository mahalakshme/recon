ActiveAdmin.register Employee do

  permit_params :name, :employee_id, :grade_id, :role_id

  filter :name
  filter :grade
  filter :role

  collection_action :autocomplete_employee_name, method: :get

  controller do
    autocomplete :employee, :name, full: true
  end

end
