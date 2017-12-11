module ItemsHelper
	def item_owner id
		User.find(id)
	end

	def is_liked id
		current_user.liked_item_ids.include?(id)
	end

	def all_users_on_waiting_list item_id
		user_array = []
		Item.find(item_id).request_id_list.each do |user_id|
			user_array << User.find(user_id)
		end
		user_array
	end

	def available? item_in
		item_in.tenant_id == nil && item_in.request_id_list.length == 0
	end

	def already_on_list? item_in
		item_in.request_id_list.include?(current_user.id)
	end

	def in_your_hand? item_in
		item_in.tenant_id == current_user.id
	end
	
end
