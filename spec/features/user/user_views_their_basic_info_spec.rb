require 'rails_helper'
require 'reddit_services_spec_helper'

RSpec.feature "User views their basic info" do
  context "logged-in user" do
    scenario "they visit the root path" do
      VCR.use_cassette("user_subreddits") do
        refresh_user_token
        user = create(:user)

        allow_any_instance_of(ApplicationController).
          to receive(:current_user).
          and_return(user)

        visit '/'

        expect(page).to have_content(user.comment_karma)
        expect(page).to have_content(user.link_karma)
        expect(page).to have_content(user.username)
        expect(page).to have_link("logout")
        expect(page).to_not have_link("Login with Reddit")
      end
    end
  end

  context "guest" do
    scenario "they visit the root path" do
      user = create(:user)

      visit '/'

      expect(page).to_not have_content(user.username)
      expect(page).to_not have_content(user.comment_karma)
      expect(page).to_not have_content(user.link_karma)
      expect(page).to have_link("Login with Reddit")
      expect(page).to_not have_content("logout")
    end
  end
end
