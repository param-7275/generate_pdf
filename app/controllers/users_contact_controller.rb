class UsersContactController < ApplicationController
	before_action :current_user

	def new_contact
		@user_contact = UserContact.new
	end
	def contact
		@user = UserContact.new(contact_params.merge(user_id: @user.id))
		if @user.save
			flash[:success] = "Message has been sent we will reach you soon !"
			redirect_to contact_path
		else
			flash[:error] = @user.errors.full_messages
			redirect_to contact_path

		end
	end

	def about
	end

	def news
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
	def contact_params
		params.require(:user_contact).permit(:name, :contact, :message)
	end
end
