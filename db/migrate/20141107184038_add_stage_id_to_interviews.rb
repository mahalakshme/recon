class AddStageIdToInterviews < ActiveRecord::Migration
  def change
    add_reference :interviews, :stage, index: true
  end
end
