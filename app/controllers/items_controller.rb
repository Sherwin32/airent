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

	private
  def item_params
    params.require(:item).permit(:title, :description, :price, :post_image)
  end

  def like_params
  	params.require(:item).permit(:item_id)
  end
end
