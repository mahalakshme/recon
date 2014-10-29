# == Schema Information
#
# Table name: employees
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  employee_id :string(255)
#  grade_id    :integer
#  role_id     :integer
#  created_at  :datetime
#  updated_at  :datetime
#
# Indexes
#
#  index_employees_on_employee_id  (employee_id)
#  index_employees_on_grade_id     (grade_id)
#  index_employees_on_role_id      (role_id)
#

class Employee < ActiveRecord::Base
  belongs_to :grade
  belongs_to :role

  validates :employee_id, presence: true, uniqueness: true
  validates :name, presence: true
  validates :grade, presence: true
  validates :role, presence: true
end
