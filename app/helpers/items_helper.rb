module ItemsHelper
	def item_owner id
		User.find(id)
	end

	def is_liked id
		if current_user.liked_item_ids.include?(id)
			true
		else
			false
		end
	end
end
