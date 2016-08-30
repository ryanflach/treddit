class Subreddit < OpenStruct
  def self.service(current_user)
    @@service ||= RedditService.new(current_user.token)
  end

  def self.all(current_user)
    subreddits_hash = service(current_user).get_subreddits
    subreddits_hash.map { |subreddit| Subreddit.new(subreddit[:data]) }
  end

  def self.find_by_name(name, current_user)
    subreddit_hash = service(current_user).get_subreddit(name)
    Subreddit.new(subreddit_hash)
  end
end
