class RedditAuthService
  attr_reader :params

  def initialize(params)
    @params = params
  end

  def prepare_user
    RandomString.destroy_all
    set_user_information
  end

  private

  def set_user_information
    token = request_user_token
    parsed = request_user_information(token)
    {
      username: parsed["name"],
      link_karma: parsed["link_karma"],
      comment_karma: parsed["comment_karma"],
      token: token
    }
  end

  def request_user_token
    url = "https://www.reddit.com/api/v1/access_token"
    conn = Faraday.new(url: url) do |build|
      build.request :url_encoded
      build.adapter :net_http
    end
    conn.basic_auth(ENV['REDDIT_CLIENT_ID'], ENV['REDDIT_SECRET'])
    response = conn.post do |req|
      req.body = {
        "grant_type"    => "authorization_code",
        "code"          => params[:code],
        "redirect_uri"  => "http://127.0.0.1:3000/auth/reddit/callback"
      }
    end
    JSON.parse(response.body)["access_token"]
  end

  def request_user_information(token)
    raw = Faraday.get("https://oauth.reddit.com/api/v1/me") do |req|
      req.headers['Authorization'] = "bearer #{token}"
    end
    data = JSON.parse(raw.body)
  end
end
