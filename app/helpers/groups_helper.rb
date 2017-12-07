module GroupsHelper
	def joined_groups
		return_groups = []
		all_groups.each do |g|
			if !g.manager_ids.include?(current_user.id) then return_groups << g end
		end
		return_groups
	end

	def managed_groups
		return_groups = []
		all_groups.each do |g|
			if g.manager_ids.include?(current_user.id) then return_groups << g end
		end
		return_groups
	end

	def all_groups
		current_user.groups
	end
end
