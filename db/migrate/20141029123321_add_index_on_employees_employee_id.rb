class AddIndexOnEmployeesEmployeeId < ActiveRecord::Migration
  def change
    add_index :employees, :employee_id
  end
end
