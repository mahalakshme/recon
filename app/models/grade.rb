# == Schema Information
#
# Table name: grades
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#  inactive   :boolean          default("false"), not null
#

class Grade < ActiveRecord::Base
  validates :name, uniqueness: true

  scope :active, -> { where(inactive: false) }
end
