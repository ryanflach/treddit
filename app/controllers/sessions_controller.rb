class SessionsController < ApplicationController
  def create
    user = User.find_by(username: @user_data[:username])
    user ? user.update(@user_data) : user = User.create!(@user_data)
    session[:user_id] = user.id
    flash[:success] = "Successfully logged in!"
    redirect_to root_path
  end

  def destroy
    session.clear
    flash[:success] = "Logged out. See you next time!"
    redirect_to root_path
  end

  def reddit_user_auth
    redirect_to reddit_login(random_string)
  end

  def process_auth_response
    if params[:code] && RandomString.last.word == params[:state]
      @user_data = RedditAuthService.new(params).prepare_user
      create
    elsif params[:error]
      flash[:danger] = "Error: #{params[:error]}"
      redirect_to root_path
    else
      flash[:danger] = "Unable to establish secure connection"
      redirect_to root_path
    end
  end

  private

  def reddit_login(random_string)
    "https://www.reddit.com/api/v1/authorize?" \
      "client_id=#{ENV['REDDIT_CLIENT_ID']}&" \
      "response_type=code&" \
      "state=#{random_string}&" \
      "redirect_uri=http://127.0.0.1:3000/auth/reddit/callback&" \
      "duration=temporary&" \
      "scope=identity mysubreddits read vote"
  end

  def random_string
    RandomString.create(word: Faker::Lorem.word).word
  end
end
