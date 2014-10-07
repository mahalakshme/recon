# == Schema Information
#
# Table name: candidates
#
#  id                  :integer          not null, primary key
#  name                :string(255)
#  skill               :string(255)
#  gender              :integer
#  sub_source_id       :integer
#  last_interview_date :date
#  created_at          :datetime
#  updated_at          :datetime
#
# Indexes
#
#  index_candidates_on_sub_source_id  (sub_source_id)
#

class Candidate < ActiveRecord::Base
  belongs_to :sub_source

  has_many :interviews, dependent: :destroy
  accepts_nested_attributes_for :interviews, allow_destroy: true

  enum gender: {
    male: 0,
    female: 1,
    unisex: 2
  }

  validates :name, presence: true
  validates :gender, presence: true
  validates :sub_source_id, presence: true

end
