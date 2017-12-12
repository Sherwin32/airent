class UserMailer < ApplicationMailer
	def sign_up_confirmation(user)
	    @user = user
	    @url  = # generate confirmation url
	    mail(to: @user.email, subject: "Welcome to Airent!")
	  end
end
