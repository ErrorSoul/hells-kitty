# == Schema Information
#
# Table name: product_attachments
#
#  id         :integer          not null, primary key
#  asset      :string
#  product_id :integer
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class ProductAttachment < ActiveRecord::Base
  belongs_to :product
  mount_uploader :asset, AssetUploader
end
