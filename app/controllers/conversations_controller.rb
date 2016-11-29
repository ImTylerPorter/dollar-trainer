class ConversationsController < ApplicationController
	before_action :authenticate_user!
	before_action :find_conversation, only: [:show, :edit, :update, :destroy]
	before_action :owned_conversation, only: [:edit, :update, :destroy]
	def index
		if current_user.trainer == true
			@conversation = Conversation.all.order("created_at DESC")
		else
			@conversation = current_user.conversations.order("created_at DESC")
		end
	end

	def show
	end

	def new
		@conversation = current_user.conversations.build
	end

	def create
		@conversation = current_user.conversations.build(conversation_params)
  	@conversation.user_id = current_user.id

		if @conversation.save
			redirect_to @conversation
		else
			flash[:alert] = "Your new question couldn't be asked!  Please check the form."

			render "new"
		end
	end

	def edit
	end

	def update
		if @conversation.update(conversation_params)
			redirect_to @conversation
		else
			render "edit"
		end
	end

	def destroy
		@conversation.destroy
		redirect_to root_path
	end

	private

	def conversation_params
		params.require(:conversation).permit(:question)
	end

	def find_conversation
		@conversation = Conversation.find(params[:id])
	end


	def owned_conversation
		unless current_user == @conversation.user
			flash[:alert] = "That qustion doesn't belong to you!"
			redirect_to root_path
		end
	end

end
