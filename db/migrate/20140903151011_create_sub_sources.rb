class CreateSubSources < ActiveRecord::Migration
  def change
    create_table :sub_sources do |t|
      t.string :name
      t.references :source, index: true

      t.timestamps
    end
  end
end
