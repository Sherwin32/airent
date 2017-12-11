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

	def tenant_name item_in
		User.find(item_in.tenant_id).user_name
	end

	# Check if current user is the item owner
	def is_owner? item_in
		item_in.owner_id == current_user.id
	end

	# Check if the not-rent-out item belongs to current user AND there's someone waiting on list
	def owner_should_check? item_in
		is_owner?(item_in) && (item_in.request_id_list.length != 0) && item_in.tenant_id == nil
	end

	# Check if the rent-out item belongs to current user
	def owner_check_rent_out? item_in
		is_owner?(item_in) && item_in.tenant_id != nil
	end

	# Check if current user is the item tenant
	def is_tenant? item_in
		item_in.tenant_id == current_user.id
	end

	# Check if current tenant is not on the waiting list
	def tenant_not_on_list? item_in
		!item_in.request_id_list.include?(current_user.id)
		# item_in.tenant_id == nil && item_in.request_id_list.length == 0
	end

	# Check if current tenant is already on the waiting list
	def already_on_list? item_in
		item_in.request_id_list.include?(current_user.id)
	end
	
end
