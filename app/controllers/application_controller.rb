class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :current_user,
                :user_subreddits

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def user_subreddits
    Subreddit.all(current_user) if current_user
  end
end
