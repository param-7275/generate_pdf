class PasswordsController < ApplicationController

	def new
		render :new
	end

	def create
		# binding.irb
		user = User.find_by(email: params[:email])
		if user
			user.generate_password_reset_token
			UserMailer.password_reset_email(user).deliver_now
			flash[:notice] = "Password reset instructions have been sent to your email."
			redirect_to login_path
		else
			# binding.irb
			redirect_to new_password_path
			flash[:error] = "User not found with the provided email."
			# render :new
		end
	end

	def edit
		# render the password reset form
	end

	def update
		user = User.find_by(password_reset_token: params[:token])
		if user && user.password_reset_sent_at > 20.minute.ago
			user.reset_password!(params[:password])
			flash[:success] = "Password has been reset successfully."
			redirect_to login_path
		else
			flash[:error] = "Password reset link has expired."
			render :edit
		end
	end
end
  