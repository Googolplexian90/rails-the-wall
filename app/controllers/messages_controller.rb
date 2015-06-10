class MessagesController < ApplicationController
  def index
    if session[:user].nil?
      @user = User.new
      render 'login'
    else
    	@messages = Message.all
      render 'wall'
    end
  end
  def create
    @message = Message.new(message_params)
    @message.user = User.find(session[:user])
    if(@message.save)
      redirect_to root_url
    else
      flash[:errors] = @message.errors.full_messages
      redirect_to root_url
    end
  end

  private
  def message_params
    params.require(:message).permit(:post)
  end

end
