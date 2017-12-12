module UsersHelper
	def prevent_hack
		if !current_user
			flash[:error] = "Please Log In :)!"
			redirect_to root
		end
	end
end
