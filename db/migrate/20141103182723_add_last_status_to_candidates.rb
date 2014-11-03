class AddLastStatusToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :last_status, :integer

    reversible do |dir|
      dir.up do
        Candidate.reset_column_information
        Interview.reset_column_information
        Candidate.find_each do |c|
          i = c.interviews.last
          c.update_columns last_interview_date: i.interview_date, last_status: i.status
        end
      end
    end
  end
end
