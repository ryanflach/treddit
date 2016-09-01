class SubredditsController < ApplicationController
  def show
    @posts = Post.all(params[:name], current_user)
  end
end
