class ItemsController < ApplicationController
	before_action :prevent_hack
	def create
		new_item = Item.new(item_params)
		new_item.owner_id = current_user.id
		new_item.history_log = "#{Time.new}: Post created! \n"
		target_group_id = params[:item][:group_target]
		target_group = Group.find(target_group_id)
		if target_group.items << new_item
			flash[:success] = "Created new post in #{target_group.name}!"
			redirect_to  user_path(current_user.id)
		else
			flash[:error] = "Oops! Something went wrong."
			redirect_to  user_path(current_user.id)
		end
	end

	def show
		@item = Item.find(params[:item_id])
	end

	def like
		current_user.liked_item_ids.push(params[:item_id].to_i)
		current_user.save
	end

	def unlike
		current_user.liked_item_ids.delete(params[:item_id].to_i)
		current_user.save
	end

	def subscribe
		@item = Item.find(params[:item_id])
		if @item.owner_id != current_user.id && !@item.request_id_list.include?(@item.id)
		# if !@item.request_id_list.include?(@item.id)
			@item.request_id_list << current_user.id
			flash[:success] = "You joined the waiting list for #{@item.title}. #{@item.request_id_list.length} people waiting"
			@item.save
		else
			flash[:error] = "Oops! Something went wrong."
		end
		redirect_to user_path(current_user.id)
		# redirect_to item_path(@item.id)
	end

	def unsubscribe
		@item = Item.find(params[:item_id])
		# if @item.owner_id != current_user.id && !@item.request_id_list.include?(@item.id)
		if @item.request_id_list.delete(current_user.id)
			flash[:notice] = "You left from the waiting list for #{@item.title}"
			@item.save
		else
			flash[:error] = "Oops! Something went wrong."
		end
		redirect_to user_path(current_user.id)
	end

	def force_unsubscribe
		@item = Item.find(params[:item_id])
		user_to_remove = User.find(params[:tenant_id].to_i)
		if @item.owner_id == current_user.id
			@item.request_id_list.delete(user_to_remove.id)
			flash[:notice] = "Removed #{user_to_remove.user_name} from waiting list"
			@item.save
		else
			flash[:error] = "Oops! Something went wrong."
		end
		redirect_to item_path(@item.id)
	end

	def confirm_rental
		@item = Item.find(params[:item_id])
		tenant = User.find(params[:tenant_id])
		@item.history_log = "#{Time.new}: Rent to #{tenant.user_name}\nNote: #{confirm_rental_params[:note]}\n" + @item.history_log
		@item.tenant_id = tenant.id
		if @item.save
			flash[:notice] = "Rent to #{tenant.user_name}"
		else
			flash[:error] = "Oops! Something went wrong."
		end
		redirect_to item_path(@item.id)
	end

	def confirm_return
		@item = Item.find(params[:item_id])
		tenant = User.find(params[:tenant_id])
		@item.history_log = "#{Time.new}: Item returned from #{tenant.user_name}\n" + @item.history_log
		@item.tenant_id = nil
		@item.request_id_list.delete(tenant.id)
		if @item.save
			flash[:notice] = "The item is returned from #{tenant.user_name}"
		else
			flash[:error] = "Oops! Something went wrong."
		end
		redirect_to item_path(@item.id)
	end

	def destroy
		@item = Item.find(params[:item_id])
		if current_user.id == @item.owner_id
			flash[:notice] = "Removed #{@item.title}"
			@item.destroy
			redirect_to user_path(current_user.id)
			return
		else
			flash[:error] = "Oops! Something went wrong."
		end
		redirect_to root_path
	end


	private
  def item_params
    params.require(:item).permit(:title, :description, :price, :post_image)
  end

  def like_params
  	params.require(:item).permit(:item_id)
  end

  def confirm_rental_params
  	params.require(:item).permit(:note)
  end
end
