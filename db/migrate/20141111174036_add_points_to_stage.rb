class AddPointsToStage < ActiveRecord::Migration
  def change
    add_column :stages, :points, :integer
  end
end
