class UsersController < ApplicationController
    
	def index
	end

	def show
		@user = User.find(session[:user_id])
	end

	def new_signup
		@user = User.new
	end

	def signup
		# binding.irb
		@user = User.new(user_params)
		if @user.save
			UserMailer.welcome_email(@user).deliver_now
			flash[:success] = "Account sucessfuly created"
			redirect_to login_path
		else
			flash[:error] = @user.errors.full_messages
			redirect_to sign_up_path
		end
	end

	def new_login
		@user = User.new
	end

	def login
	  @user = User.find_by_username(params[:user][:username])
		if @user && @user.authenticate(params[:user][:password])
			session[:user_id] = @user.id
			flash[:success] = "Logged in Sucessfully!"
			redirect_to show_path
		else
			flash[:error] ='Invalid username/password combination'
			redirect_to login_path
		end
	end

	def destroy
		if params[:id].present?
			session[:user_id] = nil
			flash[:notice] = 'User  successfully logged out.'
		end
		redirect_to root_path
	end

	def current_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      redirect_to login_path
      flash[:error] = "Must be login"
    end
  end

	private
	def user_params
		params.require(:user).permit(:username, :email, :password, :password_confirmation)
	end
end
