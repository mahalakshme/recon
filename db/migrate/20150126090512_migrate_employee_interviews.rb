class MigrateEmployeeInterviews < ActiveRecord::Migration
  def up
    execute <<-SQL
      INSERT INTO employee_interviews(interview_id, employee_id)
      SELECT id, employee_1_id FROM interviews;
    SQL
    execute <<-SQL
      INSERT INTO employee_interviews(interview_id, employee_id)
      SELECT id, employee_2_id FROM interviews;
    SQL
    execute <<-SQL
      INSERT INTO employee_interviews(interview_id, employee_id)
      SELECT id, employee_3_id FROM interviews;
    SQL
  end

  def down
    raise "This migration cannot be safely rolled back, check source code" unless ENV['IGNORE_20150126090512']
  end
end
