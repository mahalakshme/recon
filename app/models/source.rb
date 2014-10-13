# == Schema Information
#
# Table name: sources
#
#  id              :integer          not null, primary key
#  name            :string(255)
#  source_group_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#
# Indexes
#
#  index_sources_on_source_group_id  (source_group_id)
#

class Source < ActiveRecord::Base
  belongs_to :source_group

  validates :source_group, presence: true
  validates :name, presence: true
end
