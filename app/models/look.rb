# == Schema Information
#
# Table name: looks
#
#  id           :integer          not null, primary key
#  product_id_0 :integer
#  product_id_1 :integer
#  product_id_2 :integer
#  product_id_3 :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  name         :string
#

class Look < ActiveRecord::Base
  validates :name, :product_id_0, :product_id_1, :product_id_2, :product_id_3, presence: true
  validates_uniqueness_of :product_id_0, :product_id_1, :product_id_2, :product_id_3, scope: [:id]

  def products
    Product.where(id:
     [
       product_id_0,
       product_id_1,
       product_id_2,
       product_id_3
    ])
  end
end
