# == Schema Information
#
# Table name: product_colors
#
#  id         :integer          not null, primary key
#  color_id   :integer
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductColor < ActiveRecord::Base
  belongs_to :product
  belongs_to :color
end
