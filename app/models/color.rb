# == Schema Information
#
# Table name: colors
#
#  id         :integer          not null, primary key
#  code       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Color < ActiveRecord::Base
end
