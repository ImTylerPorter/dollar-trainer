class ConversationsController < ApplicationController

	before_action :find_conversation, only: [:show, :edit, :update, :destroy]

	def index
		@conversation = Conversation.all.order("created_at DESC")
	end

	def show
	end

	def new
		@conversation = Conversation.new
	end

	def create
		@conversation = Conversation.new(conversation_params)

		if @conversation.save
			redirect_to @conversation
		else
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

end
