class AnswersController < ApplicationController
respond_to :html, :json
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


def update
  @answer = @conversation.answers.find(params[:id])

  respond_to do |format|
    if @answer.update_attributes(answer_params)
      format.html { redirect_to(@answer, :notice => 'Answer was successfully updated.') }
      format.json { respond_with_bip(@answer) }
    else
      format.html { render :action => "edit" }
      format.json { respond_with_bip(@answer) }
    end
  end
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
