require 'rails_helper'
require 'services_spec_helper'

describe Subreddit do
  it "gets a users subreddits" do
    VCR.use_cassette("subreddit.all") do
      refresh_user_token
      current_user = User.create!(
        username: "test",
        link_karma: 300,
        comment_karma: 500,
        token: ENV['REDDIT_TOKEN']
      )
      subreddits = Subreddit.all(current_user)
      subreddit = subreddits.first

      expect(subreddits.count).to eq(17)
      expect(subreddit.display_name).to be_a(String)
    end
  end
end
