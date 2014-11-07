class RemoveStageFromInterviews < ActiveRecord::Migration
  def change
    remove_column :interviews, :stage, :integer
  end
end
