class Post < OpenStruct
  def self.service(current_user)
    @@service ||= RedditService.new(current_user.token)
  end

  def self.all(subreddit_posts)
    subreddit_posts.map { |post| Post.new(post[:data]) }
  end
end
