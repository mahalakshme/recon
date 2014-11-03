class ChangeInterviewDateToDateTime < ActiveRecord::Migration
  def change
    change_column :interviews, :interview_date, :datetime
  end
end
