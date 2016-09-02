require 'rails_helper'
require 'reddit_services_spec_helper'

RSpec.feature "Subreddit show page" do
  context "logged-in user" do
    scenario "they visit the root path" do
      VCR.use_cassette("subreddit_show") do
        refresh_user_token
        user = create(:user)
        # Without a cassette - this test will fail the first time
        if File.exist?('spec/vcr_cassettes/subreddit_show.yml')
          post = first_post
        end

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
          within('.post_score') do
            expect(page).to have_content(post[:score])
          end
          within('.post_title') do
            expect(page).to have_link(post[:title])
          end
          within('.post_num_comments') do
            expect(page).to have_link(post[:num_comments])
          end
        end
      end
    end
  end

  context "guest" do
    scenario "they visit /r/programming" do
      visit '/r/programming'

      expect(page).to have_content("Please login to use this site.")
      expect(current_path).to eq(root_path)
    end
  end
end

def first_post
  page = YAML.load_file("spec/vcr_cassettes/subreddit_show.yml")
  posts = JSON.parse(
    page["http_interactions"].third["response"]["body"]["string"],
    symbolize_names: true
  )
  posts[:data][:children].first[:data]
end
