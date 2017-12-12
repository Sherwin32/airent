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

	def add_manager
		@group = Group.find(params[:group_id])
		user_to_add = User.find(params[:user_id])
		if @group.manager_ids.include?(current_user.id) && !@group.manager_ids.include?(user_to_add.id)
			@group.manager_ids << user_to_add.id
			@group.save
			flash[:notice] = "Added #{user_to_add.user_name} as manager."
		else
			flash[:error] = "Something went wrong!"
			redirect_to root_path
			return
		end
		redirect_to group_path(@group.id)
	end

	def remove_manager
		@group = Group.find(params[:group_id])
		user_to_remove = User.find(params[:user_id])
		if @group.manager_ids.include?(current_user.id) && @group.manager_ids.include?(user_to_remove.id) && @group.manager_ids[0] != user_to_remove.id
			@group.manager_ids.delete(user_to_remove.id)
			@group.save
			flash[:notice] = "Removed #{user_to_remove.user_name} from manager team."
		else
			flash[:error] = "Something went wrong!"
			redirect_to root_path
			return
		end
		redirect_to group_path(@group.id)
	end

	def kick_out
		@group = Group.find(params[:group_id])
		user_to_kick_out = User.find(params[:user_id])
		if @group.manager_ids.include?(current_user.id) && @group.manager_ids[0] != user_to_kick_out.id
			@group.users.delete(user_to_kick_out)
			@group.items.each do |i|
				if i.owner_id == user_to_kick_out.id then Item.find(i.id).destroy end
			end
			@group.save
			flash[:notice] = "#{user_to_kick_out.user_name} is kicked out."
		else
			flash[:error] = "Something went wrong!"
			redirect_to root_path
			return
		end
		redirect_to group_path(@group.id)
	end

	# change passcode for a group, not user password
	def change_passcode
		@group = Group.find(params[:group_id])
		new_passcode = params.require(:group).permit(:passcode)
		if @group.manager_ids.include?(current_user.id)
			@group.update(new_passcode)
			flash[:notice] = "Passcode changed."
		else
			flash[:error] = "Something went wrong!"
			redirect_to root_path
			return
		end
		redirect_to group_path(@group.id)
	end
end
