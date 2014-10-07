# == Schema Information
#
# Table name: candidates
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  skill               :string(255)
#  gender              :integer
#  experience          :integer
#  source_id           :integer
#  role_id             :integer
#  last_interview_date :date
#  created_at          :datetime
#  updated_at          :datetime
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
  validates :experience, numericality: { greater_than_or_equal_to: 0 }
  validates :interviews, presence: true

end
