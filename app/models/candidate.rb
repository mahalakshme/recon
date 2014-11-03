# == Schema Information
#
# Table name: candidates
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  skill               :string(255)
#  gender              :integer
#  experience          :decimal(5, 2)
#  source_id           :integer
#  role_id             :integer
#  last_interview_date :date
#  created_at          :datetime
#  updated_at          :datetime
#  experience_years    :integer          default(0)
#  experience_months   :integer          default(0)
#  notes               :text
#
# Indexes
#
#  index_candidates_on_role_id    (role_id)
#  index_candidates_on_source_id  (source_id)
#

class Candidate < ActiveRecord::Base
  belongs_to :source
  belongs_to :role

  has_many :interviews, dependent: :destroy
  accepts_nested_attributes_for :interviews, allow_destroy: true

  enum gender: {
    male: 0,
    female: 1,
    unisex: 2
  }

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

end
