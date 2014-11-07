# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  interview_date :datetime
#  candidate_id   :integer
#  employee_1_id  :integer
#  employee_2_id  :integer
#  employee_3_id  :integer
#  status         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  notes          :text
#  stage_id       :integer
#
# Indexes
#
#  index_interviews_on_candidate_id   (candidate_id)
#  index_interviews_on_employee_1_id  (employee_1_id)
#  index_interviews_on_employee_2_id  (employee_2_id)
#  index_interviews_on_employee_3_id  (employee_3_id)
#  index_interviews_on_stage_id       (stage_id)
#

class Interview < ActiveRecord::Base
  default_scope { order(:interview_date) }

  belongs_to :candidate
  belongs_to :stage

  belongs_to :employee_1, class_name: 'Employee'
  belongs_to :employee_2, class_name: 'Employee'
  belongs_to :employee_3, class_name: 'Employee'

  enum status: {
    "Scheduled" => 5,
    "Pursue"    => 0,
    "Pass"      => 1,
    "Pending"   => 2,
    "Withdrew"  => 3,
    "No Show"   => 4
  }

  validates :stage, presence: true
  validates :status, presence: true
  validates :interview_date, presence: true
  validates :employee_1, presence: true

  after_save :update_last_interview_columns

  def update_last_interview_columns
    candidate.update_last_interview_columns
  end

end
