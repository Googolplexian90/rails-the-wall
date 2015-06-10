class SessionsController < ApplicationController
  def create
    @user = User.find_by(email:params[:session][:email])
    if @user.authenticate(params[:session][:password])
      #It's our user
      session[:user] = @user.id
      redirect_to root_url
    else
      flash[:errors]=@user.errors.full_messages
      redirect_to root_url
    end
  end

  def create_guest
    session[:user] = 0
    redirect_to root_url
  end

  def destroy
    session[:user]=nil
    redirect_to root_url
  end
end
