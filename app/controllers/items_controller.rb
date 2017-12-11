class ItemsController < ApplicationController
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
		# if @item.owner_id != current_user.id && !@item.request_id_list.include?(@item.id)
		if !@item.request_id_list.include?(@item.id)
			@item.request_id_list << current_user.id
			flash[:success] = "You joined the waiting list for #{@item.title}. #{@item.request_id_list.length} people waiting"
			@item.save
		else
			flash[:error] = "Oops! Something went wrong."
			redirect_to user_path(current_user.id)
		end
		redirect_to item_path(@item.id)
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

	private
  def item_params
    params.require(:item).permit(:title, :description, :price, :post_image)
  end

  def like_params
  	params.require(:item).permit(:item_id)
  end
end
