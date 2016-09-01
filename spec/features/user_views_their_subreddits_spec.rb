require 'rails_helper'
require 'reddit_services_spec_helper'

RSpec.feature "User views their subreddits" do
  context "logged-in user" do
    scenario "they visit the root path" do
      VCR.use_cassette("user_subreddits") do
        refresh_user_token
        user = create_user
        allow_any_instance_of(ApplicationController).
          to receive(:current_user).
          and_return(user)

        visit '/'

        expect(page).to have_content("My Subreddits")
        expect(page).to have_link("programming")
      end
    end
  end

  context "guest" do
    scenario "they visit the root path" do
      visit '/'

      expect(page).to_not have_content("My Subreddits")
    end
  end
end
