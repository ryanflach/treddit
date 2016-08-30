class RedditService
  def initialize(token)
    @token = token
    @connection = Faraday.new("https://oauth.reddit.com/")
    @connection.headers["Authorization"] = "bearer #{token}"
  end

  def get_subreddits
    response = @connection.get("subreddits/mine/subscriber")
    parse(response.body)[:data][:children]
  end

  def get_subreddit(name)
    response = @connection.get()
    parse(response.body)
  end

  private

  def parse(response)
    JSON.parse(response, symbolize_names: true)
  end
end
