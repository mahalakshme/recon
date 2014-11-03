class AddExperienceYearsMonthsToCandidate < ActiveRecord::Migration
  def change
    add_column :candidates, :experience_years, :integer, default: 0
    add_column :candidates, :experience_months, :integer, default: 0
    change_column :candidates, :experience, :decimal, precision: 5, scale: 2

    reversible do |dir|
      dir.up do
        Candidate.reset_column_information
        Candidate.find_each do |c|
          c.update_columns experience_years: c.experience, experience_months: 0
        end
      end
    end
  end
end
