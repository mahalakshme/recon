class CreateSourceGroups < ActiveRecord::Migration
  def change
    create_table :source_groups do |t|
      t.string :name

      t.timestamps
    end
  end
end
