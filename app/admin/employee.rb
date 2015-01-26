ActiveAdmin.register Employee do

  menu parent: 'Organization'

  permit_params :name, :employee_ref, :grade_id, :role_id, :inactive

  filter :name
  filter :grade
  filter :role
  filter :inactive

  config.sort_order = "name_asc"

  controller do
    def scoped_collection
      Employee.includes_meta
    end

    def find_resource
      Employee.includes_interviews.includes_meta.find params[:id]
    end
  end

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
    link_to "Upload Jigsaw CSV", upload_csv_admin_employees_path
  end

  index do
    column :employee_ref
    column :name
    column :role
    column :grade
    column :inactive
    actions
  end

  show do |e|
    attributes_table do
      row 'Employee ID' do e.employee_ref end
      row :name
      row :role
      row :grade
      row :inactive
      row :created_at
      row :updated_at
    end

    panel "Interviews" do
      table_for e.interviews.order(interview_date: :desc) do
        column :interview_date
        column :stage
        column :status
        column :notes
        column :employees do |i|
          i.employees.map do |e|
            link_to e.name, [:admin, e]
          end.join(', ').html_safe
        end
      end
    end
  end

end
