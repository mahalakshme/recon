# == Schema Information
#
# Table name: stages
#
#  id         :integer          not null, primary key
#  name       :string
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#  points     :integer
#

class Stage < ActiveRecord::Base
  validates_uniqueness_of :name
end
