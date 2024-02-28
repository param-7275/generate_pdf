class UserMailer < ApplicationMailer
	default from: 'paramjeet6779@gmail.com' # Set the default sender email	`	`
	def welcome_email
		@user =  params[:user]
		#@url  = 'http://yourwebsite.com/login' # Set the login URL
		mail(to: @user.email, subject: 'Welcome to My Website!')
	end

	def password_reset_email(user)
		@user = user
		@reset_url = edit_password_url(user.password_reset_token)
		mail(to: user.email, subject: "Password Reset Request")
	end
end
