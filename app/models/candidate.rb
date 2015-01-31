# == Schema Information
#
# Table name: candidates
#
#  id                  :integer          not null, primary key
#  name                :string
#  skill               :string
#  gender              :integer
#  experience          :decimal(5, 2)
#  source_id           :integer
#  role_id             :integer
#  last_interview_date :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  experience_years    :integer          default("0")
#  experience_months   :integer          default("0")
#  notes               :text
#  last_status         :integer
#  last_stage_id       :integer
#
# Indexes
#
#  index_candidates_on_last_interview_date  (last_interview_date)
#  index_candidates_on_last_stage_id        (last_stage_id)
#  index_candidates_on_role_id              (role_id)
#  index_candidates_on_source_id            (source_id)
#

class Candidate < ActiveRecord::Base
  belongs_to :source
  belongs_to :role
  belongs_to :last_stage, class_name: 'Stage'

  has_many :interviews, -> { order(:interview_date) }, dependent: :destroy
  accepts_nested_attributes_for :interviews, allow_destroy: true

  scope :includes_interviews, proc { includes(interviews: [ :stage, :employees ]) }
  scope :includes_meta, proc { includes(:role, :last_stage, source: :source_group) }

  enum gender: {
    "Male"   => 0,
    "Female" => 1,
    "Unisex" => 2
  }

  enum last_status: Interview.statuses.dup

  validates :name, presence: true
  validates :source, presence: true
  validates :role, presence: true
  validates :experience_years, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 99 }
  validates :experience_months, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 11 }
  validates :interviews, presence: true

  before_save :calculate_experience

  def calculate_experience
    self.experience = experience_years + (experience_months / 12.0)
  end

  def update_last_interview_columns
    i = interviews.last
    update_columns(
      last_interview_date: i.interview_date,
      last_status: self.class.last_statuses[i.status],
      last_stage_id: i.stage_id
    )
  end

end
