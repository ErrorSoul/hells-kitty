# == Schema Information
#
# Table name: sizes
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Size < ActiveRecord::Base
  validates :name, presence: true
  validates :name, uniqueness: true
end
