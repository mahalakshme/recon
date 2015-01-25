# == Schema Information
#
# Table name: roles
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime
#  updated_at :datetime
#  inactive   :boolean          default("false"), not null
#

class Role < ActiveRecord::Base
  validates :name, uniqueness: true

  scope :active, -> { where(inactive: false) }
end
