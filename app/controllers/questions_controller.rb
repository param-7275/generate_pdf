require 'prawn'
class QuestionsController < ApplicationController

	before_action :current_user

	def new
		@question = Question.new
	end

	def create
		@question = Question.new(question_params.merge(user_id: @user.id))
		if @question.save
			flash[:success] = "Question sucessfuly Add!"
			redirect_to show_question_path
		else
			render :new
		end
	end

	def index
		@question = Question.where(user_id: session[:user_id])
	end

	def generate_pdf
		marks = params[:marks].to_i
		user = current_user
		pages = (marks / 50).to_i 
		pdf = Prawn::Document.new
		pdf.text "Question Paper\n\n"
		pages.times do |page_number|
			pdf.start_new_page if page_number > 0
			pdf.text "Page #{page_number + 1}"
		end
		filename = "question_paper_#{user.id}_#{marks}.pdf"
		pdf.render_file(Rails.root.join('public', 'pdfs', filename))
		send_data pdf.render, filename: filename, type: "application/pdf", disposition: "inline"
	end
	
	
	def current_user
    if session[:user_id]
      @user = User.find_by(id: session[:user_id])
    else
      redirect_to login_path
      flash[:error] = "Must be login"
    end
  end
	
	def delete_question
    @question = Question.find(params[:id])
		@question.destroy
		flash[:success] = "Question sucessfuly Deleted"
		redirect_to show_question_path
	end

	private
	def question_params
		params.require(:question).permit(:question, :marks)
	end
end
  
