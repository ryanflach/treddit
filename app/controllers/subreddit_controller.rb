class SubredditController < ApplicationController
  def show
    @subreddit = Subreddit.find_by_name(params[:name])
  end
end
