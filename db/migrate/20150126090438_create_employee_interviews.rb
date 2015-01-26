class CreateEmployeeInterviews < ActiveRecord::Migration
  def change
    create_table :employee_interviews do |t|
      t.references :employee, index: true
      t.references :interview, index: true

      t.timestamps
    end
    add_foreign_key :employee_interviews, :employees
    add_foreign_key :employee_interviews, :interviews
  end
end
