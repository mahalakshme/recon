ActiveAdmin.register Employee do

  permit_params :name, :employee_id, :grade_id, :role_id

  filter :name
  filter :grade
  filter :role

end
