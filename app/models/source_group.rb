# == Schema Information
#
# Table name: source_groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class SourceGroup < ActiveRecord::Base
  has_many :sources
  validates :name, uniqueness: true
end
