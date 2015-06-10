class UsersController < ApplicationController
  def index
    #When we have admin users, maybe populate this one
  end

  def show
    @user = User.find(params[:id])
  end

  def new
    @user = User.new
  end
  def create
    @user = User.new(user_params)
    if(@user.save)
      #User successfully made, log in and go to wall
      session[:user] = @user.id
      redirect_to root_url
    else
      #Failed! Go back to the register screen
      flash[:errors]=@user.errors.full_messages
      redirect_to root_url
    end
  end

  def edit
    #Go back to the show screen if the logged-in
    #user is not the one being edited
    if(params[:id]!=session[:user])
      redirect_to users_show(id: params[:id]) and return
    end
    #Else, load the user data
    @user = User.find(params[:id]);
  end
  def update
    #Go back to the show screen if the logged-in
    #user is not the user being updated
    if(params[:id]!=session[:user])
      redirect_to users_show(id: params[:id]) and return
    end
    @user = User.find(params[:id]);
    #Try to update the user
    if @user.update(user_params)
      #Success, go to the updated show page
      redirect_to users_show(id: params[:id])
    else
      #Failed, go back to the edit screen
      flash[:errors] = @user.errors.full_messages
      redirect_to users_edit(id: params[:id])
    end
  end

  def destroy
    #Yeah, maybe in version 2
  end

  private
  def user_params
    params.require(:user).permit(:first_name,:last_name,:email,:password,:password_confirmation)
  end
end
