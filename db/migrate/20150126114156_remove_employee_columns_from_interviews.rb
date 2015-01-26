class RemoveEmployeeColumnsFromInterviews < ActiveRecord::Migration
  def change
    remove_column :interviews, :employee_1_id
    remove_column :interviews, :employee_2_id
    remove_column :interviews, :employee_3_id
  end
end
