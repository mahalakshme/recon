# == Schema Information
#
# Table name: stages
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  position   :integer
#  created_at :datetime
#  updated_at :datetime
#

class Stage < ActiveRecord::Base
end
