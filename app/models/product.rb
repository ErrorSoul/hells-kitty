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
#  public      :boolean          default("false")
#

class Product < ActiveRecord::Base
  validates :name, :price, :marking, :category_id,  presence: true
  validates :price, numericality: { only_integer: true }
  validates :marking, uniqueness: true
  validates :name, :marking, length: { in: 4..100 }

  belongs_to :category
  has_many :product_attachments, dependent: :destroy
  accepts_nested_attributes_for :product_attachments, allow_destroy: true

  has_many :product_sizes, dependent: :destroy
  has_many :product_colors, dependent: :destroy
  has_many :sizes, through: :product_sizes
  accepts_nested_attributes_for :product_sizes, allow_destroy: true,
    reject_if: proc { |attrs| attrs['name'].blank? || attrs['value'].blank? }
  has_many :colors, through: :product_colors
  accepts_nested_attributes_for :product_sizes, allow_destroy: true
  accepts_nested_attributes_for :product_colors, allow_destroy: true

end
