# == Schema Information
#
# Table name: grades
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  inactive   :boolean          default(FALSE), not null
#

class Grade < ActiveRecord::Base
  validates :name, uniqueness: true

  scope :active, -> { where(inactive: false) }
end
