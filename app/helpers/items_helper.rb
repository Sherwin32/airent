module ItemsHelper
	def item_owner id
		User.find(id)
	end

	def is_liked id
		current_user.liked_item_ids.include?(id)
	end

	
end
