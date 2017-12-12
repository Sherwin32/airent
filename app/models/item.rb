class Item < ApplicationRecord
	# validates :post_image, :presence => true
	belongs_to :group
	attachment :post_image, type: :image
end
