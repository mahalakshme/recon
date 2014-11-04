ActiveAdmin.register Employee do

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
    employees = Employee.
      where('name ILIKE ?', "%#{params[:q]}%").
      limit((params[:limit] || "15").to_i)

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
