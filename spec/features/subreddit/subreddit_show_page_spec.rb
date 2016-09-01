require 'rails_helper'
require 'reddit_services_spec_helper'

RSpec.feature "Subreddit show page" do
  context "logged-in user" do
    scenario "they visit the root path" do
      VCR.use_cassette("subreddit_show") do
        refresh_user_token
        user = create_user
        post = first_post

        allow_any_instance_of(ApplicationController).
          to receive(:current_user).
          and_return(user)

        visit '/'
        click_on 'programming'

        expect(current_path).to eq('/r/programming')
        expect(page).to have_content('Hot 15 in /r/programming')
        expect(page).to have_css("tr#post-15")
        expect(page).to_not have_css("tr#post-16")

        within("#post-1") do
          within('.post_num') do
            expect(page).to have_content(1)
          end
          within('.')
          expect(page).to have_content()
        end
      end
    end
  end

  context "guest" do
    scenario "they visit /r/programming" do
      VCR.use_cassette("subreddit_show") do
        visit '/r/programming'

        expect(current_path).to eq('/r/programming')
        expect(page).to have_content('Hot 15 in /r/programming')
      end
    end
  end
end

def first_post
  page = YAML.load_file("spec/vcr_cassettes/subreddit_show.yml")
  posts = JSON.parse(
    page["http_interactions"].last["response"]["body"]["string"]
  )
  posts["data"]["children"].first["data"]
end
