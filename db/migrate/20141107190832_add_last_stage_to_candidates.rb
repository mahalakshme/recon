class AddLastStageToCandidates < ActiveRecord::Migration
  def change
    add_reference :candidates, :last_stage, index: true

    reversible do |dir|
      dir.up do
        Candidate.reset_column_information
        Interview.reset_column_information
        Candidate.find_each(&:update_last_interview_columns)
      end
    end
  end
end
