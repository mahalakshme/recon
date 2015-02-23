# == Schema Information
#
# Table name: interviews
#
#  id             :integer          not null, primary key
#  interview_date :datetime
#  candidate_id   :integer
#  status         :integer
#  created_at     :datetime
#  updated_at     :datetime
#  notes          :text
#  stage_id       :integer
#
# Indexes
#
#  index_interviews_on_candidate_id  (candidate_id)
#  index_interviews_on_stage_id      (stage_id)
#

class Interview < ActiveRecord::Base
  belongs_to :candidate
  belongs_to :stage

  has_many :employee_interviews, dependent: :destroy
  has_many :employees, through: :employee_interviews

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

  after_save :update_last_interview_columns

  def update_last_interview_columns
    candidate.update_last_interview_columns
  end

  def employee_ids_attributes=(new_ids)
    self.employee_interviews = new_ids.flatten.uniq.map do |e|
      self.employee_interviews.new employee_id: e
    end
  end

end
