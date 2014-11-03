# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  stage          :integer
#  interview_date :date
#  candidate_id   :integer
#  employee_1_id  :integer
#  employee_2_id  :integer
#  employee_3_id  :integer
#  status         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  notes          :text
#
# Indexes
#
#  index_interviews_on_candidate_id   (candidate_id)
#  index_interviews_on_employee_1_id  (employee_1_id)
#  index_interviews_on_employee_2_id  (employee_2_id)
#  index_interviews_on_employee_3_id  (employee_3_id)
#

class Interview < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :employee_1, class_name: 'Employee'
  belongs_to :employee_2, class_name: 'Employee'
  belongs_to :employee_3, class_name: 'Employee'

  enum stage: {
    telephone: 0,
    code_review: 1,
    code_reassigned: 2,
    pairing: 3,
    round_1: 4,
    round_2: 5,
    round_3: 6,
    p3: 7,
    leadership: 8
  }

  enum status: {
    scheduled: 5,
    pursue: 0,
    pass: 1,
    pending: 2,
    withdrew: 3,
    no_show: 4
  }

  validates :stage, presence: true
  validates :status, presence: true
  validates :interview_date, presence: true
  validates :employee_1, presence: true

  after_save :update_last_interview_date

  def update_last_interview_date
    candidate.update_column :last_interview_date, interview_date if (
      candidate.last_interview_date.nil? ||
      interview_date > candidate.last_interview_date
    )
  end

end
