require 'rails_helper'
require 'reddit_services_spec_helper'

describe Post do
  it "collects 15 hot posts by subreddit" do
    VCR.use_cassette("post.all") do
      refresh_user_token
      current_user = User.create!(
        username: "test",
        link_karma: 300,
        comment_karma: 500,
        token: ENV['REDDIT_TOKEN']
      )
      posts = Post.all("programming", current_user)
      post = posts.first

      expect(posts.count).to eq(15)
      expect(post.subreddit).to eq("programming")
      expect(post.score).to be_a(Fixnum)
      expect(post.title).to be_a(String)
      expect(post.url).to be_a(String)
      expect(post.num_comments).to be_a(Fixnum)
      expect(post.comments_url).to be_a(String)
    end
  end
end
