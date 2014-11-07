ActiveAdmin.register Employee do

  menu parent: 'Organization'

  permit_params :name, :employee_ref, :grade_id, :role_id, :inactive

  filter :name
  filter :grade
  filter :role
  filter :inactive

  collection_action :upload_csv do
    render 'admin/employee/upload_csv'
  end

  collection_action :import_csv, method: :post do
    EmployeeImporter.import_file params[:dump][:file]
    flash[:notice] = 'CSV imported successfully!'
    redirect_to action: :index
  end

  collection_action :autocomplete do
    employees = Employee.limit((params[:limit] || "15").to_i)
    params[:q].split(' ').each do |param|
      employees = employees.where 'name ILIKE ?', "%#{param}%"
    end

    render json: employees.to_json(only: [:id, :name])
  end

  action_item only: :index do
    link_to "Upload Jigsaw CSV", upload_csv_employees_path
  end

  index do
    column :employee_ref
    column :name
    column :role
    column :grade
    column :inactive
    actions
  end

end
