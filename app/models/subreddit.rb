class Subreddit
  def initialize(params)
    @params = params
  end

  def self.service(current_user)
    RedditService.new(current_user.token)
  end

  def self.all(current_user)
    subreddits_hash = service(current_user).get_subreddits
    subreddits_hash.map { |subreddit| Subreddit.new(subreddit[:data]) }
  end

  def self.find_posts_by_name(name, current_user)
    # returns 15 'hot' post objects
    service(current_user).get_subreddit(name).take(15)
  end

  def display_name
    params[:display_name]
  end

  private

  attr_reader :params
end
