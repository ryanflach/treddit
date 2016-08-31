require 'rails_helper'
require 'services_spec_helper'

describe RedditService do
  context '#subreddits' do
    it "gets a user's subreddits" do
      VCR.use_cassette("reddit_service_subreddits") do
        refresh_user_token
        subreddits = RedditService.new(ENV['REDDIT_TOKEN']).
          get_subreddits
        subreddit = subreddits.first[:data]

        expect(subreddits.count).to eq(17)
        expect(subreddit).to have_key(:display_name)
        expect(subreddit[:display_name]).to be_a(String)
      end
    end

    it "gets 15 posts for an individual subreddit" do
      VCR.use_cassette("reddit_service_subreddit") do
        refresh_user_token
        posts = RedditService.new(ENV['REDDIT_TOKEN']).
          get_subreddit('programming')
        post = posts.first[:data]

        expect(posts.count).to eq(15)
        expect(post).to have_key(:url)
        expect(post).to have_key(:score)
      end
    end
  end
end
