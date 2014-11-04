class RenameEmployeeIdToRef < ActiveRecord::Migration
  def change
    rename_column :employees, :employee_id, :employee_ref
  end
end
