# == Schema Information
#
# Table name: products
#
#  id          :integer          not null, primary key
#  name        :string
#  price       :string
#  category_id :integer
#  marking     :string
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Product < ActiveRecord::Base
  validates :name, :price, :marking, presence: true
  validates :price, numericality: { only_integer: true }
  validates :marking, uniqueness: true
  validates :name, :marking, length: { in: 4..100 }

  belongs_to :category
  has_many :product_attachments
  accepts_nested_attributes_for :product_attachments, allow_destroy: true
end
