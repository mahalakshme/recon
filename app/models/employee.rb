# == Schema Information
#
# Table name: employees
#
#  id           :integer          not null, primary key
#  name         :string
#  employee_ref :string
#  grade_id     :integer
#  role_id      :integer
#  created_at   :datetime
#  updated_at   :datetime
#  inactive     :boolean          default("false"), not null
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

  has_many :employee_interviews
  has_many :interviews, through: :employee_interviews

  scope :active, -> { where(inactive: false) }

  scope :includes_interviews, proc { includes(interviews: [ :stage, :employees ]) }
  scope :includes_meta, proc { includes(:grade, :role) }

end
