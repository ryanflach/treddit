class SubredditsController < ApplicationController
  def show
    @subreddit = Subreddit.find_by_name(params[:name], current_user)
    @posts = Post.all(@subreddit)
  end
end
