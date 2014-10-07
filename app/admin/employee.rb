ActiveAdmin.register Employee do

  permit_params :name, :employee_id, :grade_id, :role_id

end
