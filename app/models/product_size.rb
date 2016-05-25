# == Schema Information
#
# Table name: product_sizes
#
#  id         :integer          not null, primary key
#  value      :integer
#  product_id :integer
#  size_id    :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductSize < ActiveRecord::Base
  belongs_to :product
  belongs_to :size
end
