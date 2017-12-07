class Group < ApplicationRecord
	has_many :user_group_connectors, dependent: :destroy
  has_many :users, through: :user_group_connectors
  has_many :items
end
