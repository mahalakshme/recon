# == Schema Information
#
# Table name: employees
#
#  id           :integer          not null, primary key
#  name         :string(255)
#  employee_ref :string(255)
#  grade_id     :integer
#  role_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  inactive     :boolean          default(FALSE), not null
#
# Indexes
#
#  index_employees_on_employee_ref  (employee_ref)
#  index_employees_on_grade_id      (grade_id)
#  index_employees_on_role_id       (role_id)
#

class Employee < ActiveRecord::Base
  belongs_to :grade
  belongs_to :role

  validates :employee_ref, presence: true, uniqueness: true
  validates :name, presence: true
  validates :grade_id, presence: true
  validates :role_id, presence: true

  scope :active, -> { where(inactive: false) }

  def interviews
    Interview.where('employee_1_id = ? OR employee_2_id = ? OR employee_3_id = ?', id, id, id)
  end
end
