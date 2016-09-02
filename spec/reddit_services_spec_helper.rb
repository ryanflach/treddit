def refresh_user_token
  url = "https://www.reddit.com/api/v1/access_token"
  conn = Faraday.new(url: url) do |build|
    build.request :url_encoded
    build.adapter :net_http
  end
  conn.basic_auth(ENV['REDDIT_CLIENT_ID'], ENV['REDDIT_SECRET'])
  response = conn.post do |req|
    req.body = {
      "grant_type"    => "refresh_token",
      "refresh_token" => ENV['REDDIT_REFRESH_TOKEN']
    }
  end
  new_token = JSON.parse(response.body)["access_token"]
  update_yml_file(new_token)
end

def update_yml_file(new_token)
  data = YAML.load_file("config/application.yml")
  data['test']['REDDIT_TOKEN'] = new_token
  File.open("config/application.yml", "w") do |f|
    YAML.dump(data, f)
  end
end
