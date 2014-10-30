class AddInactiveToGradesRolesEmployees < ActiveRecord::Migration
  def change
    add_column :roles,     :inactive, :boolean, null: false, default: false
    add_column :grades,    :inactive, :boolean, null: false, default: false
    add_column :employees, :inactive, :boolean, null: false, default: false
  end
end
