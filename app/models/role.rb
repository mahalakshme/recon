# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#  inactive   :boolean          default(FALSE), not null
#

class Role < ActiveRecord::Base
  validates :name, uniqueness: true

  scope :active, -> { where(inactive: false) }
end
