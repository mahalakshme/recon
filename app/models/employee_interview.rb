# == Schema Information
#
# Table name: employee_interviews
#
#  id           :integer          not null, primary key
#  employee_id  :integer
#  interview_id :integer
#  created_at   :datetime
#  updated_at   :datetime
#
# Indexes
#
#  index_employee_interviews_on_employee_id   (employee_id)
#  index_employee_interviews_on_interview_id  (interview_id)
#

class EmployeeInterview < ActiveRecord::Base
  belongs_to :employee
  belongs_to :interview
end
