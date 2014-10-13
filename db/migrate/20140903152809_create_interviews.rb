class CreateInterviews < ActiveRecord::Migration
  def change
    create_table :interviews do |t|
      t.integer :stage
      t.date :interview_date
      t.references :candidate, index: true
      t.references :employee_1, index: true
      t.references :employee_2, index: true
      t.references :employee_3, index: true
      t.integer :status

      t.timestamps
    end
  end
end
