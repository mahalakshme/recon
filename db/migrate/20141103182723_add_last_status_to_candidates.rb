class AddLastStatusToCandidates < ActiveRecord::Migration
  def change
    add_column :candidates, :last_status, :integer

    reversible do |dir|
      dir.up do
        Candidate.reset_column_information
        Interview.reset_column_information
        Candidate.find_each do |c|
          c.update_last_interview_columns
        end
      end
    end
  end
end
