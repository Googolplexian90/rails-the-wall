class CommentsController < ApplicationController
  def create
    @c = Comment.new(comment_params)
    if @c.parent_type == 'message'
      @c.parent = Message.find(@c.parent_id)
    elsif @c.parent_type == 'comment'
      @c.parent = Comment.find(@c.parent_id)
    else
      flash[:errors] = ["Don't hack me, bro!"]
      redirect_to root_url and return
    end
    @c.user = User.find(session[:user])
    if @c.valid?
      @c.save
      redirect_to root_url
    else
      flash[:errors] = @c.errors.full_messages
      redirect_to root_url
    end
  end
  private
  def comment_params
    params.require(:comment).permit(:post,:parent_id,:parent_type)
  end
end
