class AnswersController < ApplicationController

before_action :set_conversation
def create  
  @answer = @conversation.answers.build(answer_params)
  @answer.user_id = current_user.id

  if @answer.save
    flash[:success] = "You answered the hell out of that question!"
	  respond_to do |format|
	    format.html { redirect_to root_path }
	    format.js
		end
  else
    flash[:alert] = "Check the answer form, something went horribly wrong."
    render root_path
  end
end

def show
end

def destroy  
  @answer = @conversation.answers.find(params[:id])

  @answer.destroy
  flash[:success] = "Answer deleted :("
  redirect_to root_path
end 

private

def answer_params  
  params.require(:answer).permit(:content)
end

def set_conversation
  @conversation = Conversation.find(params[:conversation_id])
end   

def find_user
 @user = User.find(params[:user_id])

end



end
