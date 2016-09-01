class Post
  attr_reader :subreddit

  def initialize(params)
    @params = params
    @subreddit = params[:subreddit]
  end

  def self.all(name, current_user)
    subreddit_posts = Subreddit.find_posts_by_name(name, current_user)
    subreddit_posts.map { |post| Post.new(post[:data]) }
  end

  def score
    params[:score]
  end

  def title
    params[:title]
  end

  def url
    params[:url]
  end

  def num_comments
    params[:num_comments]
  end

  def comments_url
    "http://www.reddit.com#{params[:permalink]}"
  end

  private

  attr_reader :params
end
