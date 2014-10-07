class CreateEmployees < ActiveRecord::Migration
  def change
    create_table :employees do |t|
      t.string :name
      t.string :employee_id
      t.references :grade, index: true
      t.references :role, index: true

      t.timestamps
    end
  end
end
