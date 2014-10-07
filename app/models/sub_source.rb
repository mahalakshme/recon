# == Schema Information
#
# Table name: sub_sources
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  source_id  :integer
#  created_at :datetime
#  updated_at :datetime
#
# Indexes
#
#  index_sub_sources_on_source_id  (source_id)
#

class SubSource < ActiveRecord::Base
  belongs_to :source
end
