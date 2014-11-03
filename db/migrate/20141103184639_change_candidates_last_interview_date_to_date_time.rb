class ChangeCandidatesLastInterviewDateToDateTime < ActiveRecord::Migration
  def change
    change_column :candidates, :last_interview_date, :datetime
  end
end
