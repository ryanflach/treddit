class SubredditsController < ApplicationController
  def show
    if current_user
      @posts = Post.all(params[:name], current_user)
    else
      flash[:danger] = "Please login to use this site."
      redirect_to root_path
    end
  end
end
